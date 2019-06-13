Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C838945005
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jun 2019 01:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfFMXaM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 19:30:12 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42194 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfFMXaL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 19:30:11 -0400
Received: by mail-qt1-f193.google.com with SMTP id s15so423647qtk.9
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jun 2019 16:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pJLICYTglbzJPuGB86NDclpe4urK1GOgVPmREq4CQrs=;
        b=OLQvkfaqZC6x36zy3O3rMoCh3QAROZHzXSb/EkQ0SFP9cgARresQI3stMIAQ55+JmL
         DTfXWpZES/CuK+t9DaBO4u3oKLtfI2Ih17Oxr/o51XN1xPeHv5eKR3Y/T54p99DFqgWz
         JmaE5FNbOzChJWphkEZzpb3Z3699zMVMJfjhmitmxYYvutmZmQycgYzSlIrwQtEkeym5
         2ddH9LUozbidDJ64jFRJOxVqPtHt/js+u+dk0QfX4NsDbFQ/98BSDbbS8TY8PXK248Yf
         TjUsyVNplRwuWkICJOoXdhksOdI3EmtueQ/KQLTn2e2yVbM8WIFt0Tt4fo8b8ilb4xiT
         6lEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pJLICYTglbzJPuGB86NDclpe4urK1GOgVPmREq4CQrs=;
        b=M7VhJxEIXHiaAO7h8pBj/XgoGQWJKdhu4G5QjInQDvMfKxxO4z5YDib19OPOjxnNF7
         0QkfTbE0phMveD3qU6ltfWbjd2mIfYxntQubsWoh+U9jKvmhRw5Jwy7oa6pg7gvLiCtW
         iPrxzi3ODuP5JJsPNQ+c6YuvfsvKmImmecwqAs4XfE2FftCsJp/xo0XcIDOmQI8FItV0
         J+8MGMvyxOh6bvqpaJWXJD5kgCUFf2kGluEppQmv1Hy9iT3H8BuBmdMDMk7dPMBdzfY4
         ydUpW01zB/xT41Cf85zEoU83X8ii2yVQyeIpTFzS34+W3+J7ui4lflWULNkL6MOnxpv7
         73Og==
X-Gm-Message-State: APjAAAW7lSf0hrmKXvYxccZzn5SMpTIGKhklChHAXsQQKKRZ1FNjopfz
        EP4S3zi6mRH1Crfknm3z/Z31Fg==
X-Google-Smtp-Source: APXvYqxRvIeHPQ3mJIhV/SSN3uj9aCvA+F3iW/Y2iBb07jouEHhs9HOVTvK0OowWXe/szan495Hejg==
X-Received: by 2002:ac8:1b64:: with SMTP id p33mr79729875qtk.62.1560468610772;
        Thu, 13 Jun 2019 16:30:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id n124sm489580qkf.31.2019.06.13.16.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 16:30:10 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbZAX-00013N-UU; Thu, 13 Jun 2019 20:30:09 -0300
Date:   Thu, 13 Jun 2019 20:30:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 7/8] tpm: add sysfs attributes for tpm2
Message-ID: <20190613233009.GI22901@ziepe.ca>
References: <20190613180931.65445-1-swboyd@chromium.org>
 <20190613180931.65445-8-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613180931.65445-8-swboyd@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 13, 2019 at 11:09:30AM -0700, Stephen Boyd wrote:

> +static ssize_t tpm2_prop_flag_show(struct device *dev,
> +				   struct device_attribute *attr,
> +				   char *buf)
>  {
> -	/* XXX: If you wish to remove this restriction, you must first update
> -	 * tpm_sysfs to explicitly lock chip->ops.
> -	 */
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> -		return;
> +	struct tpm2_prop_flag_dev_attribute *pa =
> +		container_of(attr, struct tpm2_prop_flag_dev_attribute, attr);
> +	u32 flags;
> +	ssize_t rc;
> +
> +	rc = tpm2_get_tpm_pt(to_tpm_chip(dev), pa->property_id, &flags,
> +			     "reading property");
> +	if (rc)
> +		return 0;
> +
> +	return sprintf(buf, "%d\n", !!(flags & pa->flag_mask));
> +}
> +
> +static ssize_t tpm2_prop_u32_show(struct device *dev,
> +				  struct device_attribute *attr,
> +				  char *buf)
> +{
> +	struct tpm2_prop_u32_dev_attribute *pa =
> +		container_of(attr, struct tpm2_prop_u32_dev_attribute, attr);
> +	u32 value;
> +	ssize_t rc;
> +
> +	rc = tpm2_get_tpm_pt(to_tpm_chip(dev), pa->property_id, &value,
> +			     "reading property");
> +	if (rc)
> +		return 0;
> +
> +	return sprintf(buf, "%u\n", value);
> +}
>  
> +#define TPM2_PROP_FLAG_ATTR(_name, _property_id, _flag_mask)           \
> +	struct tpm2_prop_flag_dev_attribute attr_tpm2_prop_##_name = { \
> +		__ATTR(_name, S_IRUGO, tpm2_prop_flag_show, NULL),     \
> +		_property_id, _flag_mask                               \
> +	}
> +
> +#define TPM2_PROP_U32_ATTR(_name, _property_id)                        \
> +	struct tpm2_prop_u32_dev_attribute attr_tpm2_prop_##_name = {  \
> +		__ATTR(_name, S_IRUGO, tpm2_prop_u32_show, NULL),      \
> +		_property_id                                           \
> +	}
> +
> +TPM2_PROP_FLAG_ATTR(owner_auth_set,
> +		    TPM2_PT_PERMANENT, TPM2_ATTR_OWNER_AUTH_SET);
> +TPM2_PROP_FLAG_ATTR(endorsement_auth_set,
> +		    TPM2_PT_PERMANENT, TPM2_ATTR_ENDORSEMENT_AUTH_SET);
> +TPM2_PROP_FLAG_ATTR(lockout_auth_set,
> +		    TPM2_PT_PERMANENT, TPM2_ATTR_LOCKOUT_AUTH_SET);
> +TPM2_PROP_FLAG_ATTR(disable_clear,
> +		    TPM2_PT_PERMANENT, TPM2_ATTR_DISABLE_CLEAR);
> +TPM2_PROP_FLAG_ATTR(in_lockout,
> +		    TPM2_PT_PERMANENT, TPM2_ATTR_IN_LOCKOUT);
> +TPM2_PROP_FLAG_ATTR(tpm_generated_eps,
> +		    TPM2_PT_PERMANENT, TPM2_ATTR_TPM_GENERATED_EPS);
> +
> +TPM2_PROP_FLAG_ATTR(ph_enable,
> +		    TPM2_PT_STARTUP_CLEAR, TPM2_ATTR_PH_ENABLE);
> +TPM2_PROP_FLAG_ATTR(sh_enable,
> +		    TPM2_PT_STARTUP_CLEAR, TPM2_ATTR_SH_ENABLE);
> +TPM2_PROP_FLAG_ATTR(eh_enable,
> +		    TPM2_PT_STARTUP_CLEAR, TPM2_ATTR_EH_ENABLE);
> +TPM2_PROP_FLAG_ATTR(ph_enable_nv,
> +		    TPM2_PT_STARTUP_CLEAR, TPM2_ATTR_PH_ENABLE_NV);
> +TPM2_PROP_FLAG_ATTR(orderly,
> +		    TPM2_PT_STARTUP_CLEAR, TPM2_ATTR_ORDERLY);
> +
> +TPM2_PROP_U32_ATTR(lockout_counter, TPM2_PT_LOCKOUT_COUNTER);
> +TPM2_PROP_U32_ATTR(max_auth_fail, TPM2_PT_MAX_AUTH_FAIL);
> +TPM2_PROP_U32_ATTR(lockout_interval, TPM2_PT_LOCKOUT_INTERVAL);
> +TPM2_PROP_U32_ATTR(lockout_recovery, TPM2_PT_LOCKOUT_RECOVERY);
> +
> +#define ATTR_FOR_TPM2_PROP(_name) (&attr_tpm2_prop_##_name.attr.attr)
> +static struct attribute *tpm2_dev_attrs[] = {
> +	ATTR_FOR_TPM2_PROP(owner_auth_set),
> +	ATTR_FOR_TPM2_PROP(endorsement_auth_set),
> +	ATTR_FOR_TPM2_PROP(lockout_auth_set),
> +	ATTR_FOR_TPM2_PROP(disable_clear),
> +	ATTR_FOR_TPM2_PROP(in_lockout),
> +	ATTR_FOR_TPM2_PROP(tpm_generated_eps),
> +	ATTR_FOR_TPM2_PROP(ph_enable),
> +	ATTR_FOR_TPM2_PROP(sh_enable),
> +	ATTR_FOR_TPM2_PROP(eh_enable),
> +	ATTR_FOR_TPM2_PROP(ph_enable_nv),
> +	ATTR_FOR_TPM2_PROP(orderly),
> +	ATTR_FOR_TPM2_PROP(lockout_counter),
> +	ATTR_FOR_TPM2_PROP(max_auth_fail),
> +	ATTR_FOR_TPM2_PROP(lockout_interval),
> +	ATTR_FOR_TPM2_PROP(lockout_recovery),
> +	&dev_attr_durations.attr,
> +	&dev_attr_timeouts.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group tpm2_dev_group = {
> +	.attrs = tpm2_dev_attrs,
> +};
> +
> +void tpm_sysfs_add_device(struct tpm_chip *chip)
> +{
>  	/* The sysfs routines rely on an implicit tpm_try_get_ops, device_del
>  	 * is called before ops is null'd and the sysfs core synchronizes this
>  	 * removal so that no callbacks are running or can run again
>  	 */
> +	/* FIXME: update tpm_sysfs to explicitly lock chip->ops for TPM 2.0
> +	 */

What does the fixme mean? You cold add proper get_ops locking for the
tpm2 callbacks, it is not so hard. 

I actually think it is needed...

Oh. Jarkko, this is why you can't set ops to null in the class
shutdown, sysfs needs to be fixed first. ops can only go to null for
TPM1 after device_del until someone fixes the locking.

Jason
