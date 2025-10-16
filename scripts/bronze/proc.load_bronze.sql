/*
===============================================================================
DDL Script: Create Bronze Tables via Stored Procedure
===============================================================================
*/

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'bronze')
    EXEC('CREATE SCHEMA bronze');
GO

CREATE OR ALTER PROCEDURE bronze.table_creating
AS
BEGIN
    SET NOCOUNT ON;

    --------------------------------------------------------------------------
    -- Table: ufcstat_event_details
    --------------------------------------------------------------------------
    IF OBJECT_ID('bronze.ufcstat_event_details', 'U') IS NOT NULL
        DROP TABLE bronze.ufcstat_event_details;

    CREATE TABLE bronze.ufcstat_event_details (
        event_id NVARCHAR(20),
        fight_id NVARCHAR(20),
        date DATE,
        location NVARCHAR(250),
        winner NVARCHAR(50),
        winner_id NVARCHAR(20)
    );

    --------------------------------------------------------------------------
    -- Table: ufcstat_fight_details
    --------------------------------------------------------------------------
    IF OBJECT_ID('bronze.ufcstat_fight_details', 'U') IS NOT NULL
        DROP TABLE bronze.ufcstat_fight_details;

    CREATE TABLE bronze.ufcstat_fight_details (
        event_name NVARCHAR(250),
        event_id NVARCHAR(20),
        fight_id NVARCHAR(20),
        r_name NVARCHAR(100),
        r_id NVARCHAR(20),
        b_name NVARCHAR(100),
        b_id NVARCHAR(20),
        division NVARCHAR(100),
        title_fight BIT,
        method NVARCHAR(100),
        finish_round INT,
        match_time_sec FLOAT,
        total_rounds FLOAT,
        referee NVARCHAR(100),

        -- Red corner stats
        r_kd FLOAT,
        r_sig_str_landed FLOAT,
        r_sig_str_atmpted FLOAT,
        r_sig_str_acc FLOAT,
        r_total_str_landed FLOAT,
        r_total_str_atmpted FLOAT,
        r_total_str_acc FLOAT,
        r_td_landed FLOAT,
        r_td_atmpted FLOAT,
        r_td_acc FLOAT,
        r_sub_att FLOAT,
        r_ctrl FLOAT,
        r_head_landed FLOAT,
        r_head_atmpted FLOAT,
        r_head_acc FLOAT,
        r_body_landed FLOAT,
        r_body_atmpted FLOAT,
        r_body_acc FLOAT,
        r_leg_landed FLOAT,
        r_leg_atmpted FLOAT,
        r_leg_acc FLOAT,
        r_dist_landed FLOAT,
        r_dist_atmpted FLOAT,
        r_dist_acc FLOAT,
        r_clinch_landed FLOAT,
        r_clinch_atmpted FLOAT,
        r_clinch_acc FLOAT,
        r_ground_landed FLOAT,
        r_ground_atmpted FLOAT,
        r_ground_acc FLOAT,
        r_landed_head_per FLOAT,
        r_landed_body_per FLOAT,
        r_landed_leg_per FLOAT,
        r_landed_dist_per FLOAT,
        r_landed_clinch_per FLOAT,
        r_landed_ground_per FLOAT,

        -- Blue corner stats
        b_kd FLOAT,
        b_sig_str_landed FLOAT,
        b_sig_str_atmpted FLOAT,
        b_sig_str_acc FLOAT,
        b_total_str_landed FLOAT,
        b_total_str_atmpted FLOAT,
        b_total_str_acc FLOAT,
        b_td_landed FLOAT,
        b_td_atmpted FLOAT,
        b_td_acc FLOAT,
        b_sub_att FLOAT,
        b_ctrl FLOAT,
        b_head_landed FLOAT,
        b_head_atmpted FLOAT,
        b_head_acc FLOAT,
        b_body_landed FLOAT,
        b_body_atmpted FLOAT,
        b_body_acc FLOAT,
        b_leg_landed FLOAT,
        b_leg_atmpted FLOAT,
        b_leg_acc FLOAT,
        b_dist_landed FLOAT,
        b_dist_atmpted FLOAT,
        b_dist_acc FLOAT,
        b_clinch_landed FLOAT,
        b_clinch_atmpted FLOAT,
        b_clinch_acc FLOAT,
        b_ground_landed FLOAT,
        b_ground_atmpted FLOAT,
        b_ground_acc FLOAT,
        b_landed_head_per FLOAT,
        b_landed_body_per FLOAT,
        b_landed_leg_per FLOAT,
        b_landed_dist_per FLOAT,
        b_landed_clinch_per FLOAT,
        b_landed_ground_per FLOAT
    );

    --------------------------------------------------------------------------
    -- Table: ufcstat_fighter_details
    --------------------------------------------------------------------------
    IF OBJECT_ID('bronze.ufcstat_fighter_details', 'U') IS NOT NULL
        DROP TABLE bronze.ufcstat_fighter_details;

    CREATE TABLE bronze.ufcstat_fighter_details (
        id NVARCHAR(20),
        name NVARCHAR(100),
        nick_name NVARCHAR(100),
        wins INT,
        losses INT,
        draws INT,
        height FLOAT,
        weight FLOAT,
        reach FLOAT,
        stance NVARCHAR(50),
        dob DATE,
        splm FLOAT,
        str_acc FLOAT,
        sapm FLOAT,
        str_def FLOAT,
        td_avg FLOAT,
        td_avg_acc FLOAT,
        td_def FLOAT,
        sub_avg FLOAT
    );
END
GO
