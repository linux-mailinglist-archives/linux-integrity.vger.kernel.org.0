Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A9954653B
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jun 2022 13:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245170AbiFJLLr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jun 2022 07:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348925AbiFJLLo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jun 2022 07:11:44 -0400
Received: from smtp2.infineon.com (smtp2.infineon.com [IPv6:2a00:18f0:1e00:4::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C226149165;
        Fri, 10 Jun 2022 04:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1654859503; x=1686395503;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y4sAvL9bJG7dtdTQ88ENmVfKo81NfwYwZNMPigByyJw=;
  b=gbUn+dcQ0m3xgWM/Gm778ZxmKXheZFD9wK8I/RGxMIrab/ICyX2/7l0A
   dm4/Zy7Ocij04wxqIUUATQNnc8F1EHQXANJdImbHZMpsP344KHxC1T+kb
   LeNNVjexPtOBvop/R1puo2/5EckOaSVDFyEzRLRctrVpU5pz7xFtVCN57
   I=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="183080217"
X-IronPort-AV: E=Sophos;i="5.91,290,1647298800"; 
   d="scan'208";a="183080217"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 13:11:40 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Fri, 10 Jun 2022 13:11:40 +0200 (CEST)
Received: from [10.165.32.34] (172.23.8.247) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 10 Jun
 2022 13:11:40 +0200
Message-ID: <7f525b6f-9957-6175-1cd8-6101093bd9d9@infineon.com>
Date:   Fri, 10 Jun 2022 13:11:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 3/3] tpm: Add tpm_tis_i2c backend for tpm_tis_core
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Amir Mizinski <amirmizi6@gmail.com>
References: <20220608173113.9232-1-Alexander.Steffen@infineon.com>
 <20220608173113.9232-4-Alexander.Steffen@infineon.com>
 <YqGFs9iO/+jJvFne@iki.fi>
From:   Johannes Holland <johannes.holland@infineon.com>
In-Reply-To: <YqGFs9iO/+jJvFne@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE819.infineon.com (172.23.29.45) To
 MUCSE819.infineon.com (172.23.29.45)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 09.06.2022 07:31, Jarkko Sakkinen wrote> On Wed, Jun 08, 2022 at 07:31:13PM +0200, Alexander Steffen wrote:
>> Implement the TCG I2C Interface driver, as specified in the TCG PC
>> Client Platform TPM Profile (PTP) specification for TPM 2.0 v1.04
>> revision 14, section 8, I2C Interface Definition.
>>
>> This driver supports Guard Times. That is, if required by the TPM, the
>> driver has to wait by a vendor-specific time after each I2C read/write.
>> The specific time is read from the TPM_I2C_INTERFACE_CAPABILITY register.
>>
>> Unfortunately, the TCG specified almost but not quite compatible
>> register addresses. Therefore, the TIS register addresses need to be
>> mapped to I2C ones. The locality is stripped because for now, only
>> locality 0 is supported.
>>
>> Add a sanity check to I2C reads of e.g. TPM_ACCESS and TPM_STS. This is
>> to detect communication errors and issues due to non-standard behaviour
>> (E.g. the clock stretching quirk in the BCM2835, see 4dbfb5f4401f). In
>> case the sanity check fails, attempt a retry.
>>
>> Co-developed-by: Johannes Holland <johannes.holland@infineon.com>
>> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
>> Co-developed-by: Amir Mizinski <amirmizi6@gmail.com>
>> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
>> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
>> ---
>>  drivers/char/tpm/Kconfig       |  12 +
>>  drivers/char/tpm/Makefile      |   1 +
>>  drivers/char/tpm/tpm_tis_i2c.c | 391 +++++++++++++++++++++++++++++++++
>>  3 files changed, 404 insertions(+)
>>  create mode 100644 drivers/char/tpm/tpm_tis_i2c.c
>>
>> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
>> index 4a5516406c22..927088b2c3d3 100644
>> --- a/drivers/char/tpm/Kconfig
>> +++ b/drivers/char/tpm/Kconfig
>> @@ -74,6 +74,18 @@ config TCG_TIS_SPI_CR50
>>         If you have a H1 secure module running Cr50 firmware on SPI bus,
>>         say Yes and it will be accessible from within Linux.
>>
>> +config TCG_TIS_I2C
>> +     tristate "TPM Interface Specification 1.3 Interface / TPM 2.0 FIFO Interface - (I2C - generic)"
>> +     depends on I2C
>> +     select CRC_CCITT
>> +     select TCG_TIS_CORE
>> +     help
>> +       If you have a TPM security chip, compliant with the TCG TPM PTP
>> +       (I2C interface) specification and connected to an I2C bus master,
>> +       say Yes and it will be accessible from within Linux.
>> +       To compile this driver as a module, choose M here;
>> +       the module will be called tpm_tis_i2c.
>> +
>>  config TCG_TIS_SYNQUACER
>>       tristate "TPM Interface Specification 1.2 Interface / TPM 2.0 FIFO Interface (MMIO - SynQuacer)"
>>       depends on ARCH_SYNQUACER || COMPILE_TEST
>> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
>> index 66d39ea6bd10..0222b1ddb310 100644
>> --- a/drivers/char/tpm/Makefile
>> +++ b/drivers/char/tpm/Makefile
>> @@ -29,6 +29,7 @@ tpm_tis_spi-$(CONFIG_TCG_TIS_SPI_CR50) += tpm_tis_spi_cr50.o
>>
>>  obj-$(CONFIG_TCG_TIS_I2C_CR50) += tpm_tis_i2c_cr50.o
>>
>> +obj-$(CONFIG_TCG_TIS_I2C) += tpm_tis_i2c.o
>>  obj-$(CONFIG_TCG_TIS_I2C_ATMEL) += tpm_i2c_atmel.o
>>  obj-$(CONFIG_TCG_TIS_I2C_INFINEON) += tpm_i2c_infineon.o
>>  obj-$(CONFIG_TCG_TIS_I2C_NUVOTON) += tpm_i2c_nuvoton.o
>> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
>> new file mode 100644
>> index 000000000000..8e0686fe4eb1
>> --- /dev/null
>> +++ b/drivers/char/tpm/tpm_tis_i2c.c
>> @@ -0,0 +1,391 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2014-2021 Nuvoton Technology corporation
>> + * Copyright (C) 2019-2022 Infineon Technologies AG
>> + *
>> + * This device driver implements the TPM interface as defined in the TCG PC
>> + * Client Platform TPM Profile (PTP) Specification for TPM 2.0 v1.04
>> + * Revision 14.
>> + *
>> + * It is based on the tpm_tis_spi device driver.
>> + */
>> +
>> +#include <linux/i2c.h>
>> +#include <linux/crc-ccitt.h>
>> +#include "tpm_tis_core.h"
>> +
>> +/* TPM registers */
>> +#define TPM_I2C_LOC_SEL 0x00
>> +#define TPM_I2C_ACCESS 0x04
>> +#define TPM_I2C_INTERFACE_CAPABILITY 0x30
>> +#define TPM_I2C_DEVICE_ADDRESS 0x38
>> +#define TPM_I2C_DATA_CSUM_ENABLE 0x40
>> +#define TPM_DATA_CSUM 0x44
>> +#define TPM_I2C_DID_VID 0x48
>> +#define TPM_I2C_RID 0x4C
>> +
>> +/* TIS-compatible register address to avoid clash with TPM_ACCESS (0x00) */
>> +#define TPM_LOC_SEL 0x0FFF
>> +
>> +/* Mask to extract the I2C register from TIS register addresses */
>> +#define TPM_TIS_REGISTER_MASK 0x0FFF
>> +
>> +/* Default Guard Time of 250µs until interface capability register is read */
>> +#define GUARD_TIME_DEFAULT_MIN 250
>> +#define GUARD_TIME_DEFAULT_MAX 300
>> +
>> +/* Guard Time of 250µs after I2C slave NACK */
>> +#define GUARD_TIME_ERR_MIN 250
>> +#define GUARD_TIME_ERR_MAX 300
>> +
>> +/* Guard Time bit masks; SR is repeated start, RW is read then write, etc. */
>> +#define TPM_GUARD_TIME_SR_MASK 0x40000000
>> +#define TPM_GUARD_TIME_RR_MASK 0x00100000
>> +#define TPM_GUARD_TIME_RW_MASK 0x00080000
>> +#define TPM_GUARD_TIME_WR_MASK 0x00040000
>> +#define TPM_GUARD_TIME_WW_MASK 0x00020000
>> +#define TPM_GUARD_TIME_MIN_MASK 0x0001FE00
>> +#define TPM_GUARD_TIME_MIN_SHIFT 9
>> +
>> +/* Masks with bits that must be read zero */
>> +#define TPM_ACCESS_READ_ZERO 0x48
>> +#define TPM_INT_ENABLE_ZERO 0x7FFFFF6
>> +#define TPM_STS_READ_ZERO 0x23
>> +#define TPM_INTF_CAPABILITY_ZERO 0x0FFFF000
>> +#define TPM_I2C_INTERFACE_CAPABILITY_ZERO 0x80000000
>> +
>> +struct tpm_tis_i2c_phy {
>> +     struct tpm_tis_data priv;
>> +     struct i2c_client *i2c_client;
>> +     bool guard_time_read;
>> +     bool guard_time_write;
>> +     u16 guard_time_min;
>> +     u16 guard_time_max;
>> +     u8 *io_buf;
>> +};
>> +
>> +static inline struct tpm_tis_i2c_phy *
>> +to_tpm_tis_i2c_phy(struct tpm_tis_data *data)
>> +{
>> +     return container_of(data, struct tpm_tis_i2c_phy, priv);
>> +}
>> +
>> +/*
>> + * tpm_tis_core uses the register addresses as defined in Table 19 "Allocation
>> + * of Register Space for FIFO TPM Access" of the TCG PC Client PTP
>> + * Specification. In order for this code to work together with tpm_tis_core,
>> + * those addresses need to mapped to the registers defined for I2C TPMs in
>> + * Table 51 "I2C-TPM Register Overview".
>> + *
>> + * For most addresses this can be done by simply stripping off the locality
>> + * information from the address. A few addresses need to be mapped explicitly,
>> + * since the corresponding I2C registers have been moved around. TPM_LOC_SEL is
>> + * only defined for I2C TPMs and is also mapped explicitly here to distinguish
>> + * it from TPM_ACCESS(0).
>> + *
>> + * Locality information is ignored, since this driver assumes exclusive access
>> + * to the TPM and always uses locality 0.
>> + */
>> +static u8 tpm_tis_i2c_address_to_register(u32 addr)
>> +{
>> +     addr &= TPM_TIS_REGISTER_MASK;
>> +
>> +     switch (addr) {
>> +     case TPM_ACCESS(0):
>> +             return TPM_I2C_ACCESS;
>> +     case TPM_LOC_SEL:
>> +             return TPM_I2C_LOC_SEL;
>> +     case TPM_DID_VID(0):
>> +             return TPM_I2C_DID_VID;
>> +     case TPM_RID(0):
>> +             return TPM_I2C_RID;
>> +     default:
>> +             return addr;
>> +     }
>> +}
>> +
>> +static int tpm_tis_i2c_retry_transfer_until_ack(struct tpm_tis_data *data,
>> +                                             struct i2c_msg *msg)
>> +{
>> +     struct tpm_tis_i2c_phy *phy = to_tpm_tis_i2c_phy(data);
>> +     bool guard_time;
>> +     int i = 0;
>> +     int ret;
>> +
>> +     if (msg->flags & I2C_M_RD)
>> +             guard_time = phy->guard_time_read;
>> +     else
>> +             guard_time = phy->guard_time_write;
>> +
>> +     do {
>> +             ret = i2c_transfer(phy->i2c_client->adapter, msg, 1);
>> +             if (ret < 0)
>> +                     usleep_range(GUARD_TIME_ERR_MIN, GUARD_TIME_ERR_MAX);
>> +             else if (guard_time)
>> +                     usleep_range(phy->guard_time_min, phy->guard_time_max);
>> +             /* retry on TPM NACK */
>> +     } while (ret < 0 && i++ < TPM_RETRY);
>> +
>> +     return ret;
>> +}
>> +
>> +/* Check that bits which must be read zero are not set */
>> +static int tpm_tis_i2c_sanity_check_read(u8 reg, u16 len, u8 *buf)
>> +{
>> +     u32 zero_mask;
>> +     u32 value;
>> +
>> +     switch (len) {
>> +     case sizeof(u8):
>> +             value = buf[0];
>> +             break;
>> +     case sizeof(u16):
>> +             value = le16_to_cpup((__le16 *)buf);
>> +             break;
>> +     case sizeof(u32):
>> +             value = le32_to_cpup((__le32 *)buf);
>> +             break;
>> +     default:
>> +             /* unknown length, skip check */
>> +             return 0;
>> +     }
>> +
>> +     switch (reg) {
>> +     case TPM_I2C_ACCESS:
>> +             zero_mask = TPM_ACCESS_READ_ZERO;
>> +             break;
>> +     case TPM_INT_ENABLE(0) & TPM_TIS_REGISTER_MASK:
>> +             zero_mask = TPM_INT_ENABLE_ZERO;
>> +             break;
>> +     case TPM_STS(0) & TPM_TIS_REGISTER_MASK:
>> +             zero_mask = TPM_STS_READ_ZERO;
>> +             break;
>> +     case TPM_INTF_CAPS(0) & TPM_TIS_REGISTER_MASK:
>> +             zero_mask = TPM_INTF_CAPABILITY_ZERO;
>> +             break;
>> +     case TPM_I2C_INTERFACE_CAPABILITY:
>> +             zero_mask = TPM_I2C_INTERFACE_CAPABILITY_ZERO;
>> +             break;
>> +     default:
>> +             /* unknown register, skip check */
>> +             return 0;
>> +     }
>> +
>> +     if (unlikely((value & zero_mask) != 0x00)) {
>> +             pr_debug("TPM I2C read of register 0x%02x failed sanity check: 0x%x\n", reg, value);
>> +             return -EIO;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int tpm_tis_i2c_read_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
>> +                               u8 *result, enum tpm_tis_io_mode io_mode)
>> +{
>> +     struct tpm_tis_i2c_phy *phy = to_tpm_tis_i2c_phy(data);
>> +     struct i2c_msg msg = { .addr = phy->i2c_client->addr };
>> +     u8 reg = tpm_tis_i2c_address_to_register(addr);
>> +     int i;
>> +     int ret;
>> +
>> +     for (i = 0; i < TPM_RETRY; i++) {
>> +             /* write register */
>> +             msg.len = sizeof(reg);
>> +             msg.buf = &reg;
>> +             msg.flags = 0;
>> +             ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
>> +             if (ret < 0)
>> +                     return ret;
>> +
>> +             /* read data */
>> +             msg.buf = result;
>> +             msg.len = len;
>> +             msg.flags = I2C_M_RD;
>> +             ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
>> +             if (ret < 0)
>> +                     return ret;
>> +
>> +             ret = tpm_tis_i2c_sanity_check_read(reg, len, result);
>> +             if (ret == 0)
>> +                     return 0;
>> +
>> +             usleep_range(GUARD_TIME_ERR_MIN, GUARD_TIME_ERR_MAX);
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +static int tpm_tis_i2c_write_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
>> +                                const u8 *value,
>> +                                enum tpm_tis_io_mode io_mode)
>> +{
>> +     struct tpm_tis_i2c_phy *phy = to_tpm_tis_i2c_phy(data);
>> +     struct i2c_msg msg = { .addr = phy->i2c_client->addr };
>> +     u8 reg = tpm_tis_i2c_address_to_register(addr);
>> +     int ret;
>> +
>> +     if (len > TPM_BUFSIZE - 1)
>> +             return -EIO;
>> +
>> +     /* write register and data in one go */
>> +     phy->io_buf[0] = reg;
>> +     memcpy(phy->io_buf + sizeof(reg), value, len);
>> +
>> +     msg.len = sizeof(reg) + len;
>> +     msg.buf = phy->io_buf;
>> +     ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     return 0;
>> +}
>> +
>> +static int tpm_tis_i2c_verify_crc(struct tpm_tis_data *data, size_t len,
>> +                               const u8 *value)
>> +{
>> +     u16 crc_tpm, crc_host;
>> +     int rc;
>> +
>> +     rc = tpm_tis_read16(data, TPM_DATA_CSUM, &crc_tpm);
>> +     if (rc < 0)
>> +             return rc;
>> +
>> +     /* reflect crc result, regardless of host endianness */
>> +     crc_host = swab16(crc_ccitt(0, value, len));
>> +     if (crc_tpm != crc_host)
>> +             return -EIO;
>> +
>> +     return 0;
>> +}
>> +
>> +/*
>> + * Guard Time:
>> + * After each I2C operation, the TPM might require the master to wait.
>> + * The time period is vendor-specific and must be read from the
>> + * TPM_I2C_INTERFACE_CAPABILITY register.
>> + *
>> + * Before the Guard Time is read (or after the TPM failed to send an I2C NACK),
>> + * a Guard Time of 250µs applies.
>> + *
>> + * Various flags in the same register indicate if a guard time is needed:
>> + *  - SR: <I2C read with repeated start> <guard time> <I2C read>
>> + *  - RR: <I2C read> <guard time> <I2C read>
>> + *  - RW: <I2C read> <guard time> <I2C write>
>> + *  - WR: <I2C write> <guard time> <I2C read>
>> + *  - WW: <I2C write> <guard time> <I2C write>
>> + *
>> + * See TCG PC Client PTP Specification v1.04, 8.1.10 GUARD_TIME
>> + */
>> +static int tpm_tis_i2c_init_guard_time(struct tpm_tis_i2c_phy *phy)
>> +{
>> +     u32 i2c_caps;
>> +     int ret;
>> +
>> +     phy->guard_time_read = true;
>> +     phy->guard_time_write = true;
>> +     phy->guard_time_min = GUARD_TIME_DEFAULT_MIN;
>> +     phy->guard_time_max = GUARD_TIME_DEFAULT_MAX;
>> +
>> +     ret = tpm_tis_i2c_read_bytes(&phy->priv, TPM_I2C_INTERFACE_CAPABILITY,
>> +                                  sizeof(i2c_caps), (u8 *)&i2c_caps,
>> +                                  TPM_TIS_PHYS_32);
>> +     if (ret)
>> +             return ret;
>> +
>> +     phy->guard_time_read = (i2c_caps & TPM_GUARD_TIME_RR_MASK) ||
>> +                            (i2c_caps & TPM_GUARD_TIME_RW_MASK);
>> +     phy->guard_time_write = (i2c_caps & TPM_GUARD_TIME_WR_MASK) ||
>> +                             (i2c_caps & TPM_GUARD_TIME_WW_MASK);
>> +     phy->guard_time_min = (i2c_caps & TPM_GUARD_TIME_MIN_MASK) >>
>> +                           TPM_GUARD_TIME_MIN_SHIFT;
>> +     /* guard_time_max = guard_time_min * 1.2 */
>> +     phy->guard_time_max = phy->guard_time_min + phy->guard_time_min / 5;
>> +
>> +     return 0;
>> +}
>> +
>> +static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
>> +
>> +static const struct tpm_tis_phy_ops tpm_i2c_phy_ops = {
>> +     .read_bytes = tpm_tis_i2c_read_bytes,
>> +     .write_bytes = tpm_tis_i2c_write_bytes,
>> +     .verify_crc = tpm_tis_i2c_verify_crc,
>> +};
>> +
>> +static int tpm_tis_i2c_probe(struct i2c_client *dev,
>> +                          const struct i2c_device_id *id)
>> +{
>> +     struct tpm_tis_i2c_phy *phy;
>> +     const u8 crc_enable = 1;
>> +     const u8 locality = 0;
>> +     int ret;
>> +
>> +     phy = devm_kzalloc(&dev->dev, sizeof(struct tpm_tis_i2c_phy),
>> +                        GFP_KERNEL);
>> +     if (!phy)
>> +             return -ENOMEM;
>> +
>> +     phy->io_buf = devm_kzalloc(&dev->dev, TPM_BUFSIZE, GFP_KERNEL);
>> +     if (!phy->io_buf)
>> +             return -ENOMEM;
>> +
>> +     phy->i2c_client = dev;
>> +
>> +     /* must precede all communication with the tpm */
>> +     ret = tpm_tis_i2c_init_guard_time(phy);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = tpm_tis_i2c_write_bytes(&phy->priv, TPM_LOC_SEL, sizeof(locality),
>> +                                   &locality, TPM_TIS_PHYS_8);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = tpm_tis_i2c_write_bytes(&phy->priv, TPM_I2C_DATA_CSUM_ENABLE,
>> +                                   sizeof(crc_enable), &crc_enable,
>> +                                   TPM_TIS_PHYS_8);
>> +     if (ret)
>> +             return ret;
>> +
>> +     return tpm_tis_core_init(&dev->dev, &phy->priv, -1, &tpm_i2c_phy_ops,
>> +                              NULL);
>> +}
>> +
>> +static int tpm_tis_i2c_remove(struct i2c_client *client)
>> +{
>> +     struct tpm_chip *chip = i2c_get_clientdata(client);
>> +
>> +     tpm_chip_unregister(chip);
>> +     tpm_tis_remove(chip);
>> +     return 0;
>> +}
>> +
>> +static const struct i2c_device_id tpm_tis_i2c_id[] = {
>> +     { "tpm_tis_i2c", 0 },
>> +     {}
>> +};
>> +MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
>> +
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id of_tis_i2c_match[] = {
>> +     { .compatible = "infineon,slb9673", },
>> +     {}
>> +};
>> +MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
>> +#endif
>> +
>> +static struct i2c_driver tpm_tis_i2c_driver = {
>> +     .driver = {
>> +             .owner = THIS_MODULE,
>> +             .name = "tpm_tis_i2c",
>> +             .pm = &tpm_tis_pm,
>> +             .of_match_table = of_match_ptr(of_tis_i2c_match),
>> +     },
>> +     .probe = tpm_tis_i2c_probe,
>> +     .remove = tpm_tis_i2c_remove,
>> +     .id_table = tpm_tis_i2c_id,
>> +};
>> +module_i2c_driver(tpm_tis_i2c_driver);
>> +
>> +MODULE_DESCRIPTION("TPM Driver for native I2C access");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.25.1
>>
> 
> Looks decent, has anyone been able to test this?
> 
> BR, Jarkko

Yes, we ran kselftest and the TSS test suite. Additionally, we added/removed the
module in a loop. All ran successfully and the line coverage for tpm_tis_i2c.c
was 98.1%.

Best regards,
Johannes
