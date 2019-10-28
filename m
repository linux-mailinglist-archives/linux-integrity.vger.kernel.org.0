Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7F57E7AC1
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2019 22:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfJ1VFP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Oct 2019 17:05:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30939 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389179AbfJ1VFO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Oct 2019 17:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572296712;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TxKlhPKEe4Eb/axUY+ph5O+S3W8S8DEGprY2128AzI4=;
        b=fDgFYMnbPLvI9eKWtzxf5L57xRgEnXvp7PxlE97079SsLblRCJKCVZ4Zp+f5WhY+9H8cQD
        HJkMLyKJ7fcqQ1nm+ThwLczYeUsIMLRUQZDj0uUimdFc/P6iC8RJYHofgqwRauoMynTTYS
        ntSxhej+AFXIov+PrLQPGZjm5WwAnBI=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-zpJd9WXYMpagi7ru8m3CfA-1; Mon, 28 Oct 2019 17:05:10 -0400
Received: by mail-yb1-f197.google.com with SMTP id y64so5446496ybf.2
        for <linux-integrity@vger.kernel.org>; Mon, 28 Oct 2019 14:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=yf4+zj7RNOPk8CerubFQ1G5hNP+VaWNT7LPoqLWZ0Gk=;
        b=gio9yIk6Yf8ZIUv4eFMVkBxVxQrD7pc0ku9VfR1Wu5/UcwOiuHnlyhXypQUglO2SaK
         nvVtBSVXqZXvCzvKDgml9F0cxbFb4PyfrCUaAgDsj5ToTJzzB0p0p/Hj0dSvR+jJerJo
         MPTUDdD82kbZANlgV1a7/6EF6oTNodbpW3GCoWMvLuQ7VhT61EsCCnz9aPJwlR8t3XxU
         6VPuf6meTR5Lm5y44YZbXxfUHOCaGghNK0vICSuAo8N04FLufcferMGiTYoZ21jBvigp
         MADwiCfIRcIyiQmMfuHNCgNLSnKkBcs1eBZIhcO+zOM7hcE9SUSB9/QXFNV6lkSUktQS
         W2hg==
X-Gm-Message-State: APjAAAV/+izc3oS2hr4u63Qy6Y5I8qs1fDDEJ3mW+dcDtI7xMEBH5UBR
        10UBAZlZ+6vhd1pE7Z7bTLo+cXkqbCcBeV2nYefQ7astifPeXvAeZBvKXJtrTgQtS4IyyyOauLr
        6EnadxrwQ4AE57Myax38huqzcDy+Q
X-Received: by 2002:a25:49c7:: with SMTP id w190mr15832738yba.140.1572296709841;
        Mon, 28 Oct 2019 14:05:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxmmKVW7cJQlJOkIJYnBiX2JsU0pLw6AUn+HaxO5Jx8ZNWGwI05O9D8puCAWbLE4amCdxhDYQ==
X-Received: by 2002:a25:49c7:: with SMTP id w190mr15832711yba.140.1572296709459;
        Mon, 28 Oct 2019 14:05:09 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id j3sm9425112ywb.10.2019.10.28.14.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 14:05:08 -0700 (PDT)
Date:   Mon, 28 Oct 2019 14:05:07 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Add major_version sysfs file
Message-ID: <20191028210507.7i6d6b5olw72shm3@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
References: <20191025193103.30226-1-jsnitsel@redhat.com>
 <20191028205313.GH8279@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191028205313.GH8279@linux.intel.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: zpJd9WXYMpagi7ru8m3CfA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon Oct 28 19, Jarkko Sakkinen wrote:
>On Fri, Oct 25, 2019 at 12:31:03PM -0700, Jerry Snitselaar wrote:
>> +=09return sprintf(buf, "%s\n", chip->flags & TPM_CHIP_FLAG_TPM2
>> +=09=09       ? "2.0" : "1.2");
>
>This is not right. Should be either "1" or "2".
>
>/Jarkko

Okay I will fix that up. Do we have a final decision on the file name,
major_version versus version_major?

