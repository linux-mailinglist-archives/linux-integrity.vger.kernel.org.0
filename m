Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50388E4057
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2019 01:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbfJXX0t (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Oct 2019 19:26:49 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34294 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfJXX0t (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Oct 2019 19:26:49 -0400
Received: by mail-qk1-f193.google.com with SMTP id f18so98613qkm.1
        for <linux-integrity@vger.kernel.org>; Thu, 24 Oct 2019 16:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mbpTg5qmmsom9eXY09B3y2iC6+OCoeGXpKLIVw9dcm8=;
        b=PP7RHe29j2WqZmwfTqFwzjOSg4YdobHo+gLrNZJjbf3yCtass/AFmPUndCTtHHfOai
         bJoV4hwXZX0gxp1nNt4wexY2fw3m/TYWFjKRv7SxeoYZ+mVs8K432gspL2dDO8W5GbMe
         +u9Atd8iQJ4bYKHrN78cz2YkNRjCQ51TcqUuKP+nwPKYAiieyXitP2MtNKG15szEiNSR
         DgriH6MmkRA9Tsq3YvfBOrAk3nxVPUoeogQMZv8PJJ2CeZDP4yL1qs0LX4SNJGdkGtm4
         vcRmeQjbe90gJayLXbaYs6Eeky/FOhgRjoc3V3hZdp4rknGptb4GB518H7/LlDn3p5jp
         ULjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mbpTg5qmmsom9eXY09B3y2iC6+OCoeGXpKLIVw9dcm8=;
        b=Wm7pB5Gmg+lXg/ruFzYlIeyENQFVJdYr3K52NkQYJt5fKNppXQoq+W5ArKJIQUgNQo
         zCjcm23oG2YAuzqAbX8wqGdUFH9R1iIN3TZzELjQnz3IWEl1VxDVo9WVFq/nx710XehU
         LQc0chXvhxdC/l3FY1LmgWxzbUXyJmM4MwOhomvVbojdvsb9NDfLuCrBI+g6ELEb5Yjb
         AjTHxl68MzDJs0BedG2clD3KHpEhaKCxKVrp6l3VzcSmFyJDrg5lYA0ds10u6Kl06bAk
         M3r2AWRNJHw+7MKSfs+icY+I6n59Y9dq6bF00iI7VQNb0X/VOc+LBJ+eJQHre8C+Enmw
         tovA==
X-Gm-Message-State: APjAAAVeEhmDTLvEL9KGuhwxc8oyxziES9zVT3yoVRi4NbnvF0wGf/HW
        QxJcCbOGOEYd/6vjLXLVP7yS/qeg95c=
X-Google-Smtp-Source: APXvYqyT8mQEf9DlEJ67gpw8LUZ5tvqg6Gj1nrjmJB5sksn58cIrXKW3AHVfMS3lxY378l1QjzJCMw==
X-Received: by 2002:a37:8d7:: with SMTP id 206mr397654qki.238.1571959608032;
        Thu, 24 Oct 2019 16:26:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id j2sm142126qth.46.2019.10.24.16.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 16:26:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iNmVC-0006zY-7A; Thu, 24 Oct 2019 20:26:46 -0300
Date:   Thu, 24 Oct 2019 20:26:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Petr Vorel <pvorel@suse.cz>, Nayna <nayna@linux.vnet.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        ltp@lists.linux.it,
        Piotr =?utf-8?B?S3LDs2w=?= <piotr.krol@3mdeb.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
Message-ID: <20191024232646.GE23952@ziepe.ca>
References: <1558041162.3971.2.camel@linux.ibm.com>
 <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
 <20190517150456.GA11796@dell5510>
 <20191024121848.GA5908@dell5510>
 <20191024172023.GA7948@linux.intel.com>
 <20191024213842.c6cl4tlnsi56pgcy@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024213842.c6cl4tlnsi56pgcy@cantor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 24, 2019 at 02:38:42PM -0700, Jerry Snitselaar wrote:
> On Thu Oct 24 19, Jarkko Sakkinen wrote:
> > On Thu, Oct 24, 2019 at 02:18:48PM +0200, Petr Vorel wrote:
> > > Hi all,
> > > 
> > > I wonder what to do with this patch "ima: skip verifying TPM 2.0 PCR values" [1].
> > > Is it a correct way to differentiate between TPM 1.2 and TPM 2.0?
> > > Or something else should be applied?
> > > 
> > > How is the work on TPM 2.0 Linux sysfs interface?
> > > But even it's done in near future, we'd still need some way for older kernels.
> > > 
> > > Kind regards,
> > > Petr
> > > 
> > > [1] https://patchwork.ozlabs.org/patch/1100733/
> > 
> > version_major sysfs file would be acceptable if someone wants to proceed
> > and send such patch.
> > 
> > Also replicants for durations and timeouts files would make sense for
> > TPM 2.0.
> > 
> > /Jarkko
> 
> Is it as simple as doing this?
> 
> diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
> index edfa89160010..fd8eb8d8945c 100644
> +++ b/drivers/char/tpm/tpm-sysfs.c
> @@ -309,7 +309,17 @@ static ssize_t timeouts_show(struct device *dev, struct device_attribute *attr,
> }
> static DEVICE_ATTR_RO(timeouts);
> 
> -static struct attribute *tpm_dev_attrs[] = {
> +static ssize_t version_major_show(struct device *dev,
> +                                 struct device_attribute *attr, char *buf)
> +{
> +       struct tpm_chip *chip = to_tpm_chip(dev);

> +       return sprintf(buf, "TPM%s\n", chip->flags & TPM_CHIP_FLAG_TPM2
> +                      ? "2.0" : "1.2");

Probably no TPM prefix here

The usual sysfs naming would be more like 'major_version'

Jason
