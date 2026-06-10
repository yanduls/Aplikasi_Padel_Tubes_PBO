/*
 * Model class untuk Achievement
 * @author Copilot
 */
package com.mycompany.aplikasi_padel_tubes_pbo.model;

import java.sql.Timestamp;

public class Achievement {
    private int achievementId;
    private String name;
    private String description;
    private String icon;
    private String badgeColor;
    private String milestoneType;  // booking, community, product, premium
    private int milestoneValue;
    private Timestamp createdAt;

    // Constructor default
    public Achievement() {}

    // Constructor dengan parameter
    public Achievement(int achievementId, String name, String description, String icon, 
                      String badgeColor, String milestoneType, int milestoneValue) {
        this.achievementId = achievementId;
        this.name = name;
        this.description = description;
        this.icon = icon;
        this.badgeColor = badgeColor;
        this.milestoneType = milestoneType;
        this.milestoneValue = milestoneValue;
    }

    // Getter & Setter
    public int getAchievementId() {
        return achievementId;
    }

    public void setAchievementId(int achievementId) {
        this.achievementId = achievementId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getBadgeColor() {
        return badgeColor;
    }

    public void setBadgeColor(String badgeColor) {
        this.badgeColor = badgeColor;
    }

    public String getMilestoneType() {
        return milestoneType;
    }

    public void setMilestoneType(String milestoneType) {
        this.milestoneType = milestoneType;
    }

    public int getMilestoneValue() {
        return milestoneValue;
    }

    public void setMilestoneValue(int milestoneValue) {
        this.milestoneValue = milestoneValue;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Achievement{" +
                "achievementId=" + achievementId +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", icon='" + icon + '\'' +
                ", milestoneType='" + milestoneType + '\'' +
                ", milestoneValue=" + milestoneValue +
                '}';
    }
}
