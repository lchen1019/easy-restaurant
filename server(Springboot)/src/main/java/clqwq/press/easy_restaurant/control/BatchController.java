package clqwq.press.easy_restaurant.control;

import clqwq.press.easy_restaurant.entity.Batch;
import clqwq.press.easy_restaurant.entity.Dish;
import clqwq.press.easy_restaurant.entity.Material;
import clqwq.press.easy_restaurant.entity.Transfer;
import lombok.SneakyThrows;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.UUID;

@RestController
public class BatchController {

    /** 获取上传的excel，并根据type，完成对应的批处理操作 **/
    @SneakyThrows
    @PostMapping("batch")
    public Transfer[] batch(@RequestParam("file") MultipartFile file, @RequestParam("type") int type, @RequestParam("rid") String rid) {
        File file_out = new File(Batch.LOCATION + getUUID32() + ".xlsx");
        OutputStream out = new FileOutputStream(file_out);
        byte[] bytes = file.getBytes();
        out.write(bytes);
        // 根据type，跳转到不同的解析方法中去
        switch (type) {
            case 1: return getDishes(file_out);
        }
        return null;
    }

    public Dish[] getDishes(File excel) {
        Dish[] dishes;
        try {
            Workbook wb = new XSSFWorkbook(excel);
            Sheet sheet = wb.getSheetAt(0);
            int firstRowIndex = sheet.getFirstRowNum() + 1;
            int lastRowIndex = sheet.getLastRowNum();
            dishes = new Dish[lastRowIndex - firstRowIndex + 1];
            for (int i = firstRowIndex; i <= lastRowIndex; i++) {
                dishes[i - 1] = new Dish();
                Row row = sheet.getRow(i);
                if (row != null) {
                    int firstCellIndex = row.getFirstCellNum();
                    int lastCellIndex = row.getLastCellNum();
                    if (lastCellIndex - firstCellIndex != 6) {
                        return null;
                    }
                    dishes[i - 1].setName(row.getCell(0).toString());
                    dishes[i - 1].setPrice(Double.parseDouble(row.getCell(1).toString()));
                    dishes[i - 1].setTaste(row.getCell(2).toString());
                    dishes[i - 1].setComment(row.getCell(3).toString());
                    dishes[i - 1].setMaterials_(row.getCell(4).toString());
                    dishes[i - 1].setLocation(row.getCell(5).toString());
                }
            }
        } catch (Exception e) {
            return null;
        }
        return dishes;
    }

    public String getUUID32(){
        return UUID.randomUUID().toString().replace("-", "").toLowerCase();
    }

}
