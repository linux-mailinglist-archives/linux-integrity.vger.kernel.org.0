Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8342577C9
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Aug 2020 12:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgHaKyz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Aug 2020 06:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgHaKyw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Aug 2020 06:54:52 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A01C061573;
        Mon, 31 Aug 2020 03:54:49 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id w5so5460710wrp.8;
        Mon, 31 Aug 2020 03:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yaRd1ezQpeFZuNTb709vIWM/r8RbyFs2Etf58aEaNU4=;
        b=WcKsPr4748y/47sqozx6HwCoHlBls3OKYrUMecO/lt9X8XTnL1VQ6BK2PCQ7ZnUH3S
         HX016C8sr9le07LmG7zS+83vQTFZYGp+QHAdRNCKXlRtbwI6TpO5tqvqWNNeArvV5zSL
         sdflacYeye7dHYbxV/AJuDErbI82hVBPEjTmmR9hpUsAEvlY58ZCrW2or5LLfLzJb452
         SecG75tSQ/ifXgBGHiQCw66CbPWDLcvhx9UZuOAjB8f+qTvvbbvsXn/9p2kHK/I+ei2D
         /swUkmsw9sCwc42oQldaATeyXObjC81uzxd6C70/I2+aynmarPESHYDn4a7QbnAIFmem
         Zjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yaRd1ezQpeFZuNTb709vIWM/r8RbyFs2Etf58aEaNU4=;
        b=Nno7H3uUZwUt/JaQWXl1ib8zBYLVyVpbDDOKsLi8cNGK4Vvhbg+AqkJcpvbk7P7jUQ
         8a7NhuW5LIDlVzlupSEbldzDqO5Nt/QIAlilwKldqA78irt6ntK+ZD/H5R/6QIwsvpTA
         PLsGLFY0E7W+PUr45zfdJehmf2bRQlTIO0QIciIXp9c3+qNLxph73BB7kHBNdXqTlCjF
         KmbtonnOX0nZ0hLfhxrpPJTFFKWc16vwjwnz3SXi+lZRtdi92mACocSQv5IORX8s6f5i
         aZJjyqa7HAmcy8Rn44cM8POjB8FuaVHToQFyV/ML1zmgz40JTCfzt3TQHxsT3XsJjT+u
         75RQ==
X-Gm-Message-State: AOAM532/QvDmTICKIc1YADp8eaugvzhLdW5cr+0S5rzhn2AQVvN8U7kT
        C1dWrf4uOYTS+gx9KWCLuGc=
X-Google-Smtp-Source: ABdhPJw5z0yWDp2WlMF8EgkmUDXkB9pj7NGJdzA0QGtgPmJWn+m4QgqXWYddQTtF8BxmYgMGHwuNgA==
X-Received: by 2002:a5d:45c9:: with SMTP id b9mr1065898wrs.283.1598871288161;
        Mon, 31 Aug 2020 03:54:48 -0700 (PDT)
Received: from [192.168.1.55] (cz11.datarail.eu. [151.249.104.38])
        by smtp.gmail.com with ESMTPSA id v204sm6680489wmg.20.2020.08.31.03.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 03:54:47 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] dm-crypt: collect data and submit to DM to measure
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        zohar@linux.ibm.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20200828202700.23086-1-tusharsu@linux.microsoft.com>
 <20200828202700.23086-3-tusharsu@linux.microsoft.com>
From:   Milan Broz <gmazyland@gmail.com>
Message-ID: <02daeaf7-aefc-448a-a6b3-ab22fe054224@gmail.com>
Date:   Mon, 31 Aug 2020 12:54:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200828202700.23086-3-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 28/08/2020 22:27, Tushar Sugandhi wrote:
> Currently, dm-crypt does not take advantage of IMA measuring
> capabilities, and ultimately the benefits of remote attestation.
> 
> Measure various dm-crypt constructs by calling various device-mapper
> functions - dm_ima_*() that use IMA measuring capabilities. Implement
> ima_measure_dm_crypt_data() to measure various dm-crypt constructs.
> 
> Ensure that ima_measure_dm_crypt_data() is non intrusive, i.e. failures
> in this function and the call-stack below should not affect the core
> functionality of dm-crypt.

Just my opinion, but I really do not like to add every relevant DM table option
as a harcoded value here. (But maybe it is necessary, dunno).

Why you cannot measure the whole device-mapper table as a string?
(output of STATUSTYPE_TABLE).
But it has own problems, like table can contain key etc.

Anyway with the above, the whole measurement can reside in DM core (I hope).

But there are some problems - we can activate device with optional flags
(for example allow_discards) - should this be IMA measurement?

And what about device size (you already measure offset)?

IMO it depends on situation (policy).

It is quite often that we add performance flags later (like these no_workqueue in 5.9).
Some of them should be measured because there is possible security/data integrity impact.

And one note - input table accepts also a device path, but output of table is always
major:minor, see:

# dmsetup create test --table "0 2097152 crypt aes-cbc-essiv:sha256 9c1185a5c5e9fc54612808977ee8f548b2258d31ddadef707ba62c166051b9e3 0 /dev/sdg 0"
# dmsetup table test --showkeys
0 2097152 crypt aes-cbc-essiv:sha256 9c1185a5c5e9fc54612808977ee8f548b2258d31ddadef707ba62c166051b9e3 0 8:96 0

I think dm_table_device_name() should work here (as you use it), but major number can change
on different activations (in general) later, isn't it problem here?
(Like dynamic major for DM devices that depends on module sequence load.)

Milan

> 
> Register dm-crypt as supported data source for IMA measurement in ima.h.
> 
> A demonstrative usage of above functionality on a system:
> 
> If the IMA policy contains the following rule:
> 
>     measure func=CRITICAL_DATA critical_kernel_data_sources=dm-crypt template=ima-buf
> 
> and, the following commands are used to setup a crypt target:
> 
>  #key="faf453b4ee938cff2f0d2c869a0b743f59125c0a37f5bcd8f1dbbd911a78abaa"
>  #arg="'0 1953125 crypt aes-xts-plain64 "
>  #arg="$arg $key 0 "
>  #arg="$arg /dev/loop0 0 1 allow_discards'"
>  #tgt_name="test-crypt"
>  #cmd="dmsetup create $tgt_name --table $arg"
>  #eval $cmd
> 
> then, the IMA log at
> /sys/kernel/security/integrity/ima/ascii_runtime_measurements should
> contain the dm-crypt measurements. And, the following IMA log entry
> should be added in the IMA log,
> 
>  ima-buf sha1:039d8ff71918608d585adca3e5aab2e3f41f84d6 
>  1598637500:520585536:dm-crypt:add_target 
>  74695f6e756d5f646973636172645f62696f733d313b7065725f62696f5f646
>  174615f73697a653d3834383b646d7265715f73746172743d3136383b74666d
>  735f636f756e743d313b6f6e5f6469736b5f7461675f73697a653d303b696e7
>  46567726974795f69765f73697a653d303b696e746567726974795f7461675f
>  73697a653d303b69765f73697a653d31363b69765f6f66667365743d303b736
>  563746f725f73686966743d303b736563746f725f73697a653d3531323b666c
>  6167733d323b6369706865725f666c6167733d303b73746172743d303b6b657
>  95f6d61635f73697a653d303b6b65795f65787472615f73697a653d303b6b65
>  795f70617274733d313b6b65795f73697a653d33323b6369706865725f73747
>  2696e673d6165732d7874732d706c61696e36343b6465766963655f6e616d65
>  3d3235333a303b
> 
> where, the ascii representation of the above data is:
> 
>  ti_num_discard_bios=1;per_bio_data_size=848;dmreq_start=168;
>  tfms_count=1;on_disk_tag_size=0;integrity_iv_size=0;
>  integrity_tag_size=0;iv_size=16;iv_offset=0;sector_shift=0;
>  sector_size=512;flags=2;cipher_flags=0;start=0;key_mac_size=0;
>  key_extra_size=0;key_parts=1;key_size=32;
>  cipher_string=aes-xts-plain64;device_name=253:0;
> 
> Some of the above values can be verified using:
> 
>  #dmsetup table --showkeys
> 
> where, the output of the command should be similar to:
> 
>  test-crypt: 0 1953125 crypt aes-xts-plain64
>  faf453b4ee938cff2f0d2c869a0b743f59125c0a37f5bcd8f1dbbd911a78abaa
>  0 7:0 0 1 allow_discards
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>  drivers/md/dm-crypt.c          | 171 +++++++++++++++++++++++++++++++++
>  security/integrity/ima/Kconfig |   3 +-
>  security/integrity/ima/ima.h   |   1 +
>  3 files changed, 173 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index 148960721254..47fb2ce15211 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -2529,6 +2529,8 @@ static void crypt_dtr(struct dm_target *ti)
>  
>  	ti->private = NULL;
>  
> +	dm_ima_exit_measurements(ti->type);
> +
>  	if (!cc)
>  		return;
>  
> @@ -2991,6 +2993,167 @@ static int crypt_report_zones(struct dm_target *ti,
>  
>  #endif
>  
> +#ifdef CONFIG_IMA
> +/*
> + * append integer values to dm-crypt specific data
> + * to be measured through IMA
> + */
> +static int ima_append_num_values(struct dm_target *ti,
> +				 const char *key,
> +				 long long num_val)
> +{
> +	char *num_str = NULL;
> +	int length = 0;
> +	int r = 0;
> +
> +	if (!ti || !key) {
> +		r = -EINVAL;
> +		goto error;
> +	}
> +
> +	length = snprintf(NULL, 0, "%lld", num_val);
> +	num_str = kzalloc(length + 1, GFP_KERNEL);
> +	if (!num_str) {
> +		r = -ENOMEM;
> +		goto error;
> +	}
> +	snprintf(num_str, length + 1, "%lld", num_val);
> +	dm_ima_append_measurement_list(ti->type,
> +				       key,
> +				       (const void *)num_str,
> +				       length);
> +	kzfree(num_str);
> +	return r;
> +error:
> +	DMERR("appending num values to IMA measurement list failed %d", r);
> +	return r;
> +}
> +/*
> + * Measure dm-crypt specific data through IMA.
> + * It appends all the needed data to the list as a key-val pair using
> + * dm_ima_append_measurement_list() and internal ima_append_num_values(),
> + * and finally measures the list using dm_ima_finalize_and_measure().
> + */
> +static void ima_measure_dm_crypt_data(struct dm_target *ti, const char *desc)
> +{
> +	int r = 0;
> +	struct crypt_config *cc = NULL;
> +	const char *devname = dm_table_device_name(ti->table);
> +
> +	if (!ti) {
> +		r = -EINVAL;
> +		goto out;
> +	}
> +
> +	cc = ti->private;
> +
> +	if (devname) {
> +		dm_ima_append_measurement_list(ti->type,
> +					       "device_name",
> +					       (const void *)devname,
> +					       strlen(devname));
> +	}
> +
> +	if (cc->cipher_string) {
> +		dm_ima_append_measurement_list(ti->type,
> +					       "cipher_string",
> +					       (const void *)cc->cipher_string,
> +					       strlen(cc->cipher_string));
> +	}
> +
> +	if (cc->cipher_auth) {
> +		dm_ima_append_measurement_list(ti->type,
> +					       "cipher_auth",
> +					       (const void *)cc->cipher_auth,
> +					       strlen(cc->cipher_auth));
> +	}
> +
> +	r = ima_append_num_values(ti, "key_size", cc->key_size);
> +	if (r)
> +		goto out;
> +
> +	r = ima_append_num_values(ti, "key_parts", cc->key_parts);
> +	if (r)
> +		goto out;
> +
> +	r = ima_append_num_values(ti, "key_extra_size", cc->key_extra_size);
> +	if (r)
> +		goto out;
> +
> +	r = ima_append_num_values(ti, "key_mac_size", cc->key_mac_size);
> +	if (r)
> +		goto out;
> +
> +	r = ima_append_num_values(ti, "start", cc->start);
> +	if (r)
> +		goto out;
> +
> +	r = ima_append_num_values(ti, "cipher_flags", cc->cipher_flags);
> +	if (r)
> +		goto out;
> +
> +	r = ima_append_num_values(ti, "flags", cc->flags);
> +	if (r)
> +		goto out;
> +
> +	r = ima_append_num_values(ti, "sector_size", cc->sector_size);
> +	if (r)
> +		goto out;
> +
> +	r = ima_append_num_values(ti, "sector_shift", cc->sector_shift);
> +	if (r)
> +		goto out;
> +
> +	r = ima_append_num_values(ti, "iv_offset", cc->iv_offset);
> +	if (r)
> +		goto out;
> +
> +	r = ima_append_num_values(ti, "iv_size", cc->iv_size);
> +	if (r)
> +		goto out;
> +
> +	r = ima_append_num_values(ti, "integrity_tag_size", cc->integrity_tag_size);
> +	if (r)
> +		goto out;
> +
> +	r = ima_append_num_values(ti, "integrity_iv_size", cc->integrity_iv_size);
> +	if (r)
> +		goto out;
> +
> +	r = ima_append_num_values(ti, "on_disk_tag_size", cc->on_disk_tag_size);
> +	if (r)
> +		goto out;
> +
> +	r = ima_append_num_values(ti, "tfms_count", cc->tfms_count);
> +	if (r)
> +		goto out;
> +
> +	r = ima_append_num_values(ti, "dmreq_start", cc->dmreq_start);
> +	if (r)
> +		goto out;
> +
> +	r = ima_append_num_values(ti, "per_bio_data_size", cc->per_bio_data_size);
> +	if (r)
> +		goto out;
> +
> +	r = ima_append_num_values(ti, "ti_num_discard_bios",
> +			      ti->num_discard_bios);
> +	if (r)
> +		goto out;
> +
> +	dm_ima_finalize_and_measure(ti->type, desc, false);
> +	return;
> +
> +out:
> +	DMERR("IMA measurement of dm-crypt data failed %d", r);
> +
> +}
> +#else
> +static inline void ima_measure_dm_crypt_data(struct dm_target *ti,
> +					     const char *desc) {}
> +#endif /* CONFIG_IMA */
> +
> +
>  /*
>   * Construct an encryption mapping:
>   * <cipher> [<key>|:<key_size>:<user|logon>:<key_description>] <iv_offset> <dev_path> <start>
> @@ -3186,6 +3349,10 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  
>  	ti->num_flush_bios = 1;
>  
> +	dm_ima_init_measurements(ti->type);
> +
> +	ima_measure_dm_crypt_data(ti, "add_target");
> +
>  	return 0;
>  
>  bad:
> @@ -3324,6 +3491,8 @@ static void crypt_postsuspend(struct dm_target *ti)
>  	struct crypt_config *cc = ti->private;
>  
>  	set_bit(DM_CRYPT_SUSPENDED, &cc->flags);
> +
> +	ima_measure_dm_crypt_data(ti, "post_suspend");
>  }
>  
>  static int crypt_preresume(struct dm_target *ti)
> @@ -3343,6 +3512,8 @@ static void crypt_resume(struct dm_target *ti)
>  	struct crypt_config *cc = ti->private;
>  
>  	clear_bit(DM_CRYPT_SUSPENDED, &cc->flags);
> +
> +	ima_measure_dm_crypt_data(ti, "resume");
>  }
>  
>  /* Message interface
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 953314d145bb..ad643cc5aad4 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -324,8 +324,7 @@ config IMA_MEASURE_ASYMMETRIC_KEYS
>  
>  config IMA_QUEUE_EARLY_BOOT_DATA
>  	bool
> -	depends on IMA_MEASURE_ASYMMETRIC_KEYS
> -	depends on SYSTEM_TRUSTED_KEYRING
> +        depends on (IMA_MEASURE_ASYMMETRIC_KEYS && SYSTEM_TRUSTED_KEYRING) || DM_CRYPT
>  	default y
>  
>  config IMA_SECURE_AND_OR_TRUSTED_BOOT
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 422fe833037d..bc922aa2ff92 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -230,6 +230,7 @@ struct modsig;
>  
>  #define __ima_supported_kernel_data_sources(source)	\
>  	source(MIN_SOURCE, min_source)			\
> +	source(DM_CRYPT, dm-crypt)			\
>  	source(MAX_SOURCE, max_source)
>  
>  #define __ima_enum_stringify(ENUM, str) (#str),
> 
