package com.springboot.springfinal.model;

public class ImageDo {
    
    private int imageId;
    private int diaryId;
    private String originalName;
    private String storedName;

    public ImageDo() {
    }

    public ImageDo(int diaryId, String originalName, String storedName) {
        this.diaryId = diaryId;
        this.originalName = originalName;
        this.storedName = storedName;
    }

    public int getImageId() {
        return imageId;
    }

    public void setImageId(int imageId) {
        this.imageId = imageId;
    }

    public int getDiaryId() {
        return diaryId;
    }

    public void setDiaryId(int diaryId) {
        this.diaryId = diaryId;
    }

    public String getOriginalName() {
        return originalName;
    }

    public void setOriginalName(String originalName) {
        this.originalName = originalName;
    }

    public String getStoredName() {
        return storedName;
    }

    public void setStoredName(String storedName) {
        this.storedName = storedName;
    }
}