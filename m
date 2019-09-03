Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07F0BA7283
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Sep 2019 20:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfICS1u (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Sep 2019 14:27:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbfICS1u (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Sep 2019 14:27:50 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 51C5736887
        for <linux-integrity@vger.kernel.org>; Tue,  3 Sep 2019 18:27:49 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id t6so11457962qkm.7
        for <linux-integrity@vger.kernel.org>; Tue, 03 Sep 2019 11:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=07Nosu99Mp1zqKp4ye8H9IkjaI2ZBjCJN3UDTKMkL/I=;
        b=nTVcGIv+L0n3zu6SxX0LlZp8gwOy6MPk318rIQmijAZJm8Nw2dbdGe/MF4JxW6tuzM
         VTiEemBOnQtDDGdiyQtT3nfFPM09hi4aInVDrAHpaoW0OEJgn/F51gcCipNm75nm95zr
         RQjRxTQcXL2wVPIvE2eyD4TqdAAQYqUwkE/2MyRoJ7jjfV0eL9HMxQEB6aMqvNXPAkf4
         lqOCegvz7B2W3jdO1rW4O/bGhB1E6wAimrt+6t6J/x1W3Hw8fH1/JV58XzY2GHopDxXe
         XwQSjxJSPThFkGdn1lFCSuGuyHkSoAlvh9UreBCV5SHORoHlnuQpxyyuZd9ik0Uq9sqU
         +fug==
X-Gm-Message-State: APjAAAUHcBCrfdVgnE/QJaWROQeiKr9vxkxH9NJkrqAvxtc9viIiU5ww
        5OgAO8UNovKKUeUHmUb9SoBYHhFN82gq5EoLzQN+Mjus9jFMfBudkVfomUxRd4m4633J4UzC0VU
        pXuCPAayM2veJJS2biJlEAYMdh7Up
X-Received: by 2002:aed:27c1:: with SMTP id m1mr15498668qtg.197.1567535268663;
        Tue, 03 Sep 2019 11:27:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqztOEl0H8g/hPHQCmeKx+cH2srAaosbtrUNr/jReZ5cxMrICdEyZyhC5Lxe2bZk0gPYyqchpw==
X-Received: by 2002:aed:27c1:: with SMTP id m1mr15498636qtg.197.1567535268421;
        Tue, 03 Sep 2019 11:27:48 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id c26sm10902892qtk.93.2019.09.03.11.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 11:27:47 -0700 (PDT)
Date:   Tue, 3 Sep 2019 11:27:42 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jordan Hand <jorhand@linux.microsoft.com>
Cc:     jarkko.sakkinen@linux.intel.com, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tpm: Parse event log from TPM2 ACPI table
Message-ID: <20190903182742.rmqthgu6rms3uill@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jordan Hand <jorhand@linux.microsoft.com>,
        jarkko.sakkinen@linux.intel.com, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190831051027.11544-1-jorhand@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190831051027.11544-1-jorhand@linux.microsoft.com>
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Aug 30 19, Jordan Hand wrote:
>For systems with a TPM2 chip which use ACPI to expose event logs, retrieve the
>crypto-agile event log from the TPM2 ACPI table. The TPM2 table is defined
>in section 7.3 of the TCG ACPI Specification (see link).
>
>The TPM2 table is used by SeaBIOS in place of the TCPA table when the system's
>TPM is version 2.0 to denote (among other metadata) the location of the
>crypto-agile log.
>
>Link: https://trustedcomputinggroup.org/resource/tcg-acpi-specification/
>Signed-off-by: Jordan Hand <jorhand@linux.microsoft.com>
>---
> drivers/char/tpm/eventlog/acpi.c | 60 ++++++++++++++++++++++----------
> 1 file changed, 41 insertions(+), 19 deletions(-)
>
>diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
>index 63ada5e53f13..38a8bcec1dd5 100644
>--- a/drivers/char/tpm/eventlog/acpi.c
>+++ b/drivers/char/tpm/eventlog/acpi.c
>@@ -41,17 +41,23 @@ struct acpi_tcpa {
> 	};
> };
>
>+/* If an event log is present, the TPM2 ACPI table will contain the full
>+ * trailer
>+ */
>+
> /* read binary bios log */
> int tpm_read_log_acpi(struct tpm_chip *chip)
> {
>-	struct acpi_tcpa *buff;
>+	struct acpi_table_header *buff;
>+	struct acpi_tcpa *tcpa;
>+	struct acpi_tpm2_trailer *tpm2_trailer;
> 	acpi_status status;
> 	void __iomem *virt;
> 	u64 len, start;
>+	int log_type;
> 	struct tpm_bios_log *log;
>-
>-	if (chip->flags & TPM_CHIP_FLAG_TPM2)
>-		return -ENODEV;
>+	bool is_tpm2 = chip->flags & TPM_CHIP_FLAG_TPM2;
>+	acpi_string table_sig;
>
> 	log = &chip->log;
>
>@@ -61,26 +67,42 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
> 	if (!chip->acpi_dev_handle)
> 		return -ENODEV;
>
>-	/* Find TCPA entry in RSDT (ACPI_LOGICAL_ADDRESSING) */
>-	status = acpi_get_table(ACPI_SIG_TCPA, 1,
>-				(struct acpi_table_header **)&buff);
>+	/* Find TCPA or TPM2 entry in RSDT (ACPI_LOGICAL_ADDRESSING) */
>+	table_sig = is_tpm2 ? ACPI_SIG_TPM2 : ACPI_SIG_TCPA;
>+	status = acpi_get_table(table_sig, 1, &buff);
>
> 	if (ACPI_FAILURE(status))
> 		return -ENODEV;
>
>-	switch(buff->platform_class) {
>-	case BIOS_SERVER:
>-		len = buff->server.log_max_len;
>-		start = buff->server.log_start_addr;
>-		break;
>-	case BIOS_CLIENT:
>-	default:
>-		len = buff->client.log_max_len;
>-		start = buff->client.log_start_addr;
>-		break;
>+	if (!is_tpm2) {
>+		tcpa = (struct acpi_tcpa *)buff;
>+		switch (tcpa->platform_class) {
>+		case BIOS_SERVER:
>+			len = tcpa->server.log_max_len;
>+			start = tcpa->server.log_start_addr;
>+			break;
>+		case BIOS_CLIENT:
>+		default:
>+			len = tcpa->client.log_max_len;
>+			start = tcpa->client.log_start_addr;
>+			break;
>+		}
>+		log_type = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
>+	} else if (buff->length ==
>+		   sizeof(struct acpi_table_tpm2) +
>+		   sizeof(struct acpi_tpm2_trailer)) {
>+		tpm2_trailer = (struct acpi_tpm2_trailer *)buff;
>+
>+		len = tpm2_trailer.minimum_log_length;
>+		start = tpm2_trailer.log_address;

Are your builds not failing here? Both v3 and v4 have this.

>+		log_type = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
>+	} else {
>+		return -ENODEV;
> 	}
>+
> 	if (!len) {
>-		dev_warn(&chip->dev, "%s: TCPA log area empty\n", __func__);
>+		dev_warn(&chip->dev, "%s: %s log area empty\n",
>+			 __func__, table_sig);
> 		return -EIO;
> 	}
>
>@@ -98,7 +120,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
> 	memcpy_fromio(log->bios_event_log, virt, len);
>
> 	acpi_os_unmap_iomem(virt, len);
>-	return EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
>+	return log_type;
>
> err:
> 	kfree(log->bios_event_log);
>-- 
>2.20.1
>
