Return-Path: <linux-integrity+bounces-6937-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E08EFB382CF
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Aug 2025 14:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27191B6655C
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Aug 2025 12:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0C5307AFD;
	Wed, 27 Aug 2025 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQFeKdOv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54300302760
	for <linux-integrity@vger.kernel.org>; Wed, 27 Aug 2025 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756298929; cv=none; b=EVZpxnelJy4rYSkFZV29KDfZqWLZu0XgYe7/JPeYt629SWr32GQbUl+3gDHzrlrZo5A7kPCSCasNhe1n75CHoGZDmPMAhOOR96y4lFJYy4VUgwoH08t2fQPcT1eG+HAeSB5I9aquJuzFH976GYkqSF9l8+RxJ/Qloq12Qrpnj2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756298929; c=relaxed/simple;
	bh=k86i1x6vg3s3/qe68BtyJ0Pdez7yvIA7B8R1MY+MvuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peRlpW2jp/0H3xqJF5Tdv+USgzcBRCaAQHALsdycgqtIkZcCHcF/YMQWZCXF5VHh5oqY2eiNKN7URueDtUXOWzRL7qT8tso+As7lblzX7UICjVu7YkA7pvai0bjkSLTGYVgWGGA40CpHUmS8ktdfHt/NMxH4nu2TCjTZjsC3PWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQFeKdOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FE6C4CEEB;
	Wed, 27 Aug 2025 12:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756298929;
	bh=k86i1x6vg3s3/qe68BtyJ0Pdez7yvIA7B8R1MY+MvuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BQFeKdOvUIw2GbIjltjXpo7cdAj77HAAnbl/U7rgEnQOFF/PbELxN9MtYBGQiUjd9
	 4KFXQx4RxUJm4YFC45bKBr6ly8Byv+MmzWc16oGfF7ulXT65zksGK8sTu8AtgJZPol
	 HgD7cgSPFv94pCcmUCVwoDooO7A1EqVuWFeaG6aGoXhOc3zB+Vv4bWkXciMwN13PPt
	 5oybAUCdp+4UhCYU0PNGl5Mvg5qo6ww3960Ugj9wY2JsY8fQs6wUktegueYReIns8Q
	 WltNXVv2Ay1xfrFULcOA3JZ5MC2VyNxaaKXFgCM8z15A7AJ/NCu0CGNvJ1+e7TKeBg
	 4hOAVtVI3VEIw==
Date: Wed, 27 Aug 2025 15:48:45 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Denis Aleksandrov <daleksan@redhat.com>, peterhuewe@gmx.de,
	jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	Jan Stancek <jstancek@redhat.com>
Subject: Re: [PATCH v2] tpm: prevents local DOS via tpm/tpm0/ppi/*operations
Message-ID: <aK7-rTTqg--lM9if@kernel.org>
References: <20250827022102.17731-1-daleksan@redhat.com>
 <e576d3a8-2693-4445-8cd0-997afb5e5dc2@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e576d3a8-2693-4445-8cd0-997afb5e5dc2@molgen.mpg.de>

On Wed, Aug 27, 2025 at 07:55:23AM +0200, Paul Menzel wrote:
> Dear Denis,
> 
> 
> Thank you for your patch. In the summary, I’d use imperative mood:

+1

> 
> tpm: Prevent local DOS …
> 
> Am 27.08.25 um 04:21 schrieb Denis Aleksandrov:
> > Reads on tpm/tpm0/ppi/*operations can become very long on
> > misconfigured systems. Reading the TPM is a blocking operation,
> > thus a user could effectively trigger a DOS.
> > 
> > Resolve this by caching the results and avoiding the blocking
> > operations after the first read.
> 
> If you could elaborate, how to test this, and in possible error cases, how
> to debug this – for example, how to disable the cache–, that’d be great.

+1

> 
> > 
> > Reported-by: Jan Stancek <jstancek@redhat.com>
> > Signed-off-by: Denis Aleksandrov <daleksan@redhat.com>
> > ---
> > 
> > Changes in v2:
> >   - Replaced file permission change with a caching mechanism as
> >     suggested by Jarkko.
> > 
> >   drivers/char/tpm/tpm_ppi.c | 88 ++++++++++++++++++++++++++++----------
> >   1 file changed, 65 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> > index d53fce1c9d6f..e0212893748e 100644
> > --- a/drivers/char/tpm/tpm_ppi.c
> > +++ b/drivers/char/tpm/tpm_ppi.c
> > @@ -33,6 +33,21 @@ static const guid_t tpm_ppi_guid =
> >   	GUID_INIT(0x3DDDFAA6, 0x361B, 0x4EB4,
> >   		  0xA4, 0x24, 0x8D, 0x10, 0x08, 0x9D, 0x16, 0x53);
> > +static const char * const tpm_ppi_info[] = {
> > +	"Not implemented",
> > +	"BIOS only",
> > +	"Blocked for OS by BIOS",
> 
> Is this x86 specific? If not maybe use *system firmware*?
> 
> > +	"User required",
> > +	"User not required",
> > +};
> > +
> > +/* A spinlock to protect access to the cache from concurrent reads */
> > +static DEFINE_SPINLOCK(tpm_ppi_lock);
> > +
> > +static u32 ppi_operations_cache[PPI_VS_REQ_END + 1];
> > +
> > +static bool ppi_cache_populated;
> > +
> >   static bool tpm_ppi_req_has_parameter(u64 req)
> >   {
> >   	return req == 23;
> > @@ -277,8 +292,7 @@ static ssize_t tpm_show_ppi_response(struct device *dev,
> >   	return status;
> >   }
> > -static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
> > -				   u32 end)
> > +static ssize_t cache_ppi_operations(acpi_handle dev_handle, char *buf)
> >   {
> >   	int i;
> >   	u32 ret;
> > @@ -286,34 +300,22 @@ static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
> >   	union acpi_object *obj, tmp;
> >   	union acpi_object argv = ACPI_INIT_DSM_ARGV4(1, &tmp);
> > -	static char *info[] = {
> > -		"Not implemented",
> > -		"BIOS only",
> > -		"Blocked for OS by BIOS",
> > -		"User required",
> > -		"User not required",
> > -	};
> > -
> >   	if (!acpi_check_dsm(dev_handle, &tpm_ppi_guid, TPM_PPI_REVISION_ID_1,
> >   			    1 << TPM_PPI_FN_GETOPR))
> >   		return -EPERM;
> >   	tmp.integer.type = ACPI_TYPE_INTEGER;
> > -	for (i = start; i <= end; i++) {
> > +	for (i = 0; i <= PPI_VS_REQ_END; i++) {
> >   		tmp.integer.value = i;
> >   		obj = tpm_eval_dsm(dev_handle, TPM_PPI_FN_GETOPR,
> >   				   ACPI_TYPE_INTEGER, &argv,
> >   				   TPM_PPI_REVISION_ID_1);
> > -		if (!obj) {
> > +		if (!obj)
> >   			return -ENOMEM;
> > -		} else {
> > -			ret = obj->integer.value;
> > -			ACPI_FREE(obj);
> > -		}
> > -		if (ret > 0 && ret < ARRAY_SIZE(info))
> > -			len += sysfs_emit_at(buf, len, "%d %d: %s\n",
> > -					     i, ret, info[ret]);
> > +		ret = obj->integer.value;
> > +		ppi_operations_cache[i] = ret;
> > +		ACPI_FREE(obj);
> >   	}
> >   	return len;
> > @@ -323,20 +325,60 @@ static ssize_t tpm_show_ppi_tcg_operations(struct device *dev,
> >   					   struct device_attribute *attr,
> >   					   char *buf)
> >   {
> > +	int i;
> > +	ssize_t len = 0;
> > +	u32 ret;
> >   	struct tpm_chip *chip = to_tpm_chip(dev);
> > -	return show_ppi_operations(chip->acpi_dev_handle, buf, 0,
> > -				   PPI_TPM_REQ_MAX);
> > +	spin_lock(&tpm_ppi_lock);
> > +	if (!ppi_cache_populated) {
> > +		len = cache_ppi_operations(chip->acpi_dev_handle, buf);
> > +
> > +		if (len < 0)
> > +			return len;
> > +
> > +		ppi_cache_populated = true;
> > +	}
> > +
> > +	for (i = 0; i <= PPI_TPM_REQ_MAX; i++) {
> > +		ret = ppi_operations_cache[i];
> > +		if (ret > 0 && ret < ARRAY_SIZE(tpm_ppi_info))
> > +			len += sysfs_emit_at(buf, len, "%d %d: %s\n",
> > +							i, ret, tpm_ppi_info[ret]);
> > +	}
> > +	spin_unlock(&tpm_ppi_lock);
> > +
> > +	return len;
> >   }
> >   static ssize_t tpm_show_ppi_vs_operations(struct device *dev,
> >   					  struct device_attribute *attr,
> >   					  char *buf)
> >   {
> > +	int i;
> > +	ssize_t len = 0;
> > +	u32 ret;
> >   	struct tpm_chip *chip = to_tpm_chip(dev);
> > -	return show_ppi_operations(chip->acpi_dev_handle, buf, PPI_VS_REQ_START,
> > -				   PPI_VS_REQ_END);
> > +	spin_lock(&tpm_ppi_lock);
> > +	if (!ppi_cache_populated) {
> > +		len = cache_ppi_operations(chip->acpi_dev_handle, buf);
> > +
> > +		if (len < 0)
> > +			return len;
> > +
> > +		ppi_cache_populated = true;
> > +	}
> > +
> > +	for (i = PPI_VS_REQ_START; i <= PPI_VS_REQ_END; i++) {
> > +		ret = ppi_operations_cache[i];
> > +		if (ret > 0 && ret < ARRAY_SIZE(tpm_ppi_info))
> > +			len += sysfs_emit_at(buf, len, "%d %d: %s\n",
> > +							i, ret, tpm_ppi_info[ret]);
> > +	}
> > +	spin_unlock(&tpm_ppi_lock);
> > +
> > +	return len;
> >   }
> >   static DEVICE_ATTR(version, S_IRUGO, tpm_show_ppi_version, NULL);
> 
> The diff looks good. Feel free to carry:
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Could you look at the next patch as a sanity check for the issues that
you addressed? I highly appreciate your great comments on details like
the ones you put out, thank you.

> 
> 
> Kind regards,
> 
> Paul Menzel

BR, Jarkko

