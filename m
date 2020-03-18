Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C00D18A84B
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Mar 2020 23:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgCRWfp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Mar 2020 18:35:45 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36818 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCRWfp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Mar 2020 18:35:45 -0400
Received: by mail-qt1-f193.google.com with SMTP id m33so177085qtb.3
        for <linux-integrity@vger.kernel.org>; Wed, 18 Mar 2020 15:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RhKkOM3b73+SqbFIo7hXR89joO3mVm2xuh2r9R0UJAU=;
        b=WhrVOzIZjfGqMtoJLSU/8B+vpAX0KzmrPOyRaB4p44ABZ1rfa8h22X3W23XhQtZlVe
         EHFXfkIIpM/l63+xuvfsrAx+/Vw/G0YR8aAjcHfmNThjmxBPkRn0z1hKG+F+S8pZQmjz
         hBqrw21HhngX5cnWexV+yppEao+OT6MuIzBuQXfiBbw1/GIW7nMiI7JZ30uPU+yqbnrd
         vsRT926fuCX58mQo6tbDjkA7VrjhyRu+OYElRqlRNbIC7AgFdkoo/bOyfQzQsUCzqYRo
         yPg2GBD24ka+n8MvuwSUBKFed13j6xdXVHfsIg3DfWsMWyoJnfr9zHPEdv2cnEYwMUU+
         Thkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RhKkOM3b73+SqbFIo7hXR89joO3mVm2xuh2r9R0UJAU=;
        b=ggLHiwxbtQftl4R7sfa9zjL3tSCvJz6PeBu6vBUnHlLOq24wFCdSbRPfRDjN2SRcnf
         gub6m4CDEk7UFRhntRdb97uZhn3yVkE0SzsfRjTdarDJKWRKVHPNtzM2IrpfkC+04s9x
         1rOTvXyEg5r9WX1YtUWFiM/OkDCni9wa/u8jhczj7i9jiu9Uv3OJokNYpcATpfvtO1cJ
         CirbKxUWJYBRJTIDQCkDcnGwpK4jsk4ZEeVLD+7jjs8Y0pIWhSxJSImbDbKxLM6Mn/Rb
         PV8m2T1kljnwWQaIo1v0pLiDnsf5suVq6z6u9n6pj0jF7fy+knXgGBDU9/H7oXG9XZvu
         J7Bw==
X-Gm-Message-State: ANhLgQ0th21Xktd5o9LeNGx6Ek2pibwG1qOrYdntVUfdmaQhhP38ieFx
        XtbmlKBrMKr+dyUmFno9LxoTKQ==
X-Google-Smtp-Source: ADFU+vuIGfOWs5zpaMxj9pIV+cXJGTA7IPUuUJDipiGDUwSNYNmjn9yaBO/yPCkYnT8wT6e0VL8Hrw==
X-Received: by 2002:aed:2be5:: with SMTP id e92mr7243738qtd.374.1584570943737;
        Wed, 18 Mar 2020 15:35:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x5sm145093qti.5.2020.03.18.15.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 15:35:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jEhHq-0000C1-LW; Wed, 18 Mar 2020 19:35:42 -0300
Date:   Wed, 18 Mar 2020 19:35:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     George Wilson <gcwilson@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Linh Pham <phaml@us.ibm.com>
Subject: Re: [PATCH v2] tpm: ibmvtpm: retry on H_CLOSED in tpm_ibmvtpm_send()
Message-ID: <20200318223542.GD20941@ziepe.ca>
References: <20200317214600.9561-1-gcwilson@linux.ibm.com>
 <20200318204318.GA48352@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318204318.GA48352@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 18, 2020 at 10:43:18PM +0200, Jarkko Sakkinen wrote:
> >  static const char tpm_ibmvtpm_driver_name[] = "tpm_ibmvtpm";
> >  
> >  static const struct vio_device_id tpm_ibmvtpm_device_table[] = {
> > @@ -147,6 +149,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
> >  {
> >  	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
> >  	int rc, sig;
> > +	bool retry = true;
> 
> Cosmetic: would be nice to have inits when possible in reverse
> Christmas tree order i.e.
> 
> 	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
> 	bool retry = true;
> 	int rc, sig;
> 
> It is way more pleasing for the eye when you have to read the source
> code.

I thought only netdev insisted on that :O

Jason
