Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526A73258F7
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Feb 2021 22:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhBYVvF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Feb 2021 16:51:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231326AbhBYVvE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Feb 2021 16:51:04 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11PLX9Ie141464;
        Thu, 25 Feb 2021 16:50:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=thGox3M7QE5o6ksULSEzekAWf1zqdbQ1tLKaibQ1o+8=;
 b=hsg+rpema/mBx7wjMj8/ssrVBGllf6vyEd2LFmhI00Mxphi9LGbFOHNs2qQNHAdVySxR
 WM4NELjwncC4lfxr/MVCLEAAsYw7PeZ2/bZM40Me+y9BoCAwi6vMlQo+DNHWxUO/GGCO
 IznI1m+FlG4i6pRoRvGLUjqgQZ2ch49ghQQ0iOPfiF5j+p14TFqbSuvqfZocBxl34Ztf
 CQaeDcumIcpxHtnAWXNOGAo3UVzzgOqzqi8iHadTq4CQskgdhXxdabtJxvUQJS39zXyh
 fGYGKGDFcSs7uH9TLXFWRqxm4Z/sWta51LXWQY7nEn64HcknsLq/Oif62BMmGaw2PP9t dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36xfcxh5hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 16:50:17 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11PLY6Rd001533;
        Thu, 25 Feb 2021 16:50:16 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36xfcxh5h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 16:50:16 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11PLm5Gd009838;
        Thu, 25 Feb 2021 21:50:15 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03wdc.us.ibm.com with ESMTP id 36tt29hwmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 21:50:15 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11PLoEH836962594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 21:50:14 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 311386A057;
        Thu, 25 Feb 2021 21:50:14 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EE886A04D;
        Thu, 25 Feb 2021 21:50:13 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 25 Feb 2021 21:50:13 +0000 (GMT)
Subject: Re: [PATCH 1/3] tpm: Add support for reading a TPM NV Index
To:     Patrick Uiterwijk <patrick@puiterwijk.org>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, linux-integrity@vger.kernel.org
Cc:     pbrobinson@gmail.com, kgold@linux.ibm.com
References: <20210225203229.363302-1-patrick@puiterwijk.org>
 <20210225203229.363302-2-patrick@puiterwijk.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <cf2339c2-2fed-2cc0-d215-658606abf146@linux.ibm.com>
Date:   Thu, 25 Feb 2021 16:50:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210225203229.363302-2-patrick@puiterwijk.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_14:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 malwarescore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102250163
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/25/21 3:32 PM, Patrick Uiterwijk wrote:
> Add support to read contents from a TPM2 Non-Volatile Index location,
> allowing the kernel to retrieve contents and attributes of NV indexes.
>
> Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>
> ---
>   drivers/char/tpm/tpm-interface.c |  30 ++++++
>   drivers/char/tpm/tpm.h           |   5 +
>   drivers/char/tpm/tpm2-cmd.c      | 163 +++++++++++++++++++++++++++++++
>   include/linux/tpm.h              |  65 ++++++++++++
>   4 files changed, 263 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1621ce818705..9d81c11181d4 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -342,6 +342,36 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>   }
>   EXPORT_SYMBOL_GPL(tpm_pcr_extend);
>   
> +/**
> + * tpm_nv_read - Read an NV Index from the TPM
> + * @chip:	A &struct tpm_chip instance, %NULL for the default chip
> + * @nv_idx:	The NV Index to be retrieved
> + * @attr_out:	A place to store returned attributes if a TPM 2 was used
> + * @out:	A pointer where to store the return buffer
> + *
> + * Return: number of bytes read or a negative error value
> + */
> +int tpm_nv_read(struct tpm_chip *chip, u32 nv_idx, u32 *attr_out, void **out)
> +{
> +	int rc;
> +
> +	chip = tpm_find_get_ops(chip);
> +	if (!chip)
> +		return -ENODEV;
> +
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +		rc = tpm2_nv_read(chip, nv_idx, attr_out, out);
> +		goto out;
> +	}
> +
> +	rc = -ENODEV;
> +
> +out:
> +	tpm_put_ops(chip);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(tpm_nv_read);
> +
>   /**
>    * tpm_send - send a TPM command
>    * @chip:	a &struct tpm_chip instance, %NULL for the default chip
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 947d1db0a5cc..d4dfc5148adb 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -56,9 +56,12 @@ enum tpm_addr {
>   #define TPM_ERR_DEACTIVATED     0x6
>   #define TPM_ERR_DISABLED        0x7
>   #define TPM_ERR_INVALID_POSTINIT 38
> +#define TPM_ERR_INVALID_HANDLE_1 0x18b
>   
>   #define TPM_TAG_RQU_COMMAND 193
>   
> +#define TPM2_HR_NV_INDEX 0x1000000
> +
>   /* TPM2 specific constants. */
>   #define TPM2_SPACE_BUFFER_SIZE		16384 /* 16 kB */
>   
> @@ -224,6 +227,8 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
>   ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
>   			u32 *value, const char *desc);
>   
> +int tpm2_nv_read(struct tpm_chip *chip, u32 nvindex, u32 *attr_out, void **dest);
> +int tpm2_nv_readpublic(struct tpm_chip *chip, u32 nvindex, struct tpm2_nv_public *info);
>   ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip);
>   int tpm2_auto_startup(struct tpm_chip *chip);
>   void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index eff1f12d981a..ba1026123464 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -269,6 +269,169 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>   	return rc;
>   }
>   
> +struct tpm2_buffer_out {
> +	__be16	size;
> +	u8	data[];
> +} __packed;
> +
> +struct tpm2_nv_public_out {
> +	__be32	nvIndex;
> +	__be16	nameAlg;
> +	__be32	attributes;
> +	__be16	authPolicySize;
> +	u8	data[];
> +} __packed;
> +
> +int tpm2_nv_readpublic(struct tpm_chip *chip, u32 nvindex, struct tpm2_nv_public *info)
> +{
> +	struct tpm_buf buf;
> +	int rc;
> +	u16 recd;
> +	u32 resp_header_length;
> +	struct tpm2_buffer_out *out;
> +	struct tpm2_nv_public_out *publicout;
> +	u32 nvhandle;
> +	u16 auth_policy_size;
> +
> +	if ((nvindex & ~TPM2_HR_NV_INDEX) > 0x00FFFFFF)
> +		return -EINVAL;
> +
> +	/* HR_NV_INDEX = TPM_HT_NV_INDEX << HR_SHIFT */
> +	nvhandle = TPM2_HR_NV_INDEX | nvindex;
> +
> +	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_NV_READPUBLIC);
> +	if (rc)
> +		return rc;
> +	tpm_buf_append_u32(&buf, nvhandle);
> +	rc = tpm_transmit_cmd(chip, &buf, 0, NULL);
> +	if (rc) {
> +		if (rc != TPM_ERR_DISABLED && rc != TPM_ERR_DEACTIVATED

These are TPM 1.2 error codes. I don't think TPM 2 returns those, does 
it? Ah, you took that from tpm_transmit_cmd... I think you can remove those.


> +		    && rc != TPM2_RC_TESTING && rc != TPM_ERR_INVALID_HANDLE_1)
> +			dev_err(&chip->dev, "A TPM error (%d) occurred attempting to read an NV Index public\n", rc);
> +		if (rc == TPM_ERR_INVALID_HANDLE_1)
> +			rc = -ENOENT;
> +		else if (rc > 0)
> +			rc = -EIO;
> +		goto out;
> +	}
> +	resp_header_length = tpm_buf_response_header_length(&buf, 0);
> +	out = (struct tpm2_buffer_out *)&buf.data[resp_header_length];
> +	publicout = (struct tpm2_nv_public_out *)&out->data;
> +	recd = be16_to_cpu(out->size);
> +
> +	info->nv_index = be32_to_cpu(publicout->nvIndex);
> +	info->name_alg = be16_to_cpu(publicout->nameAlg);
> +	info->attributes = be32_to_cpu(publicout->attributes);
> +
> +	/* Determine the size of the authPolicy, so we can skip over that to grab the data size */
> +	auth_policy_size = be16_to_cpu(publicout->authPolicySize);
> +
> +	info->data_size = be16_to_cpu((publicout->data[auth_policy_size]) | (publicout->data[auth_policy_size+1] << 8));


I don't think this is correct. The way you read the 2 bytes they are 
already in native format then due to the shifting. So be16_to_cpu should 
return the wrong result on little endian machines.


> +
> +out:
> +	tpm_buf_destroy(&buf);
> +	return rc;
> +}
> +
> +int tpm2_nv_read(struct tpm_chip *chip, u32 nvindex, u32 *attr_out, void **dest)
> +{
> +	struct tpm_buf buf;
> +	int rc;
> +	struct tpm2_buffer_out *out;
> +	u16 recd;
> +	u16 copied;
> +	u32 nvhandle;
> +	u32 resp_header_length;
> +	struct tpm2_null_auth_area auth_area;
> +	u16 size;
> +	struct tpm2_nv_public public;
> +
> +	copied = 0;
> +
> +	if ((nvindex & ~TPM2_HR_NV_INDEX) > 0x00FFFFFF)
> +		return -EINVAL;
> +
> +	/* HR_NV_INDEX = TPM_HT_NV_INDEX << HR_SHIFT */
> +	nvhandle = TPM2_HR_NV_INDEX | nvindex;
> +
> +	/* Determine the size of the NV Index contents */
> +	rc = tpm2_nv_readpublic(chip, nvindex, &public);
> +	if (rc < 0)
> +		return rc;
> +	if (attr_out != NULL)
> +		*attr_out = public.attributes;
> +	size = public.data_size;
> +	*dest = kzalloc(size, GFP_KERNEL);
> +	if (!*dest) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* Retrieve the actual NV Index contents */
> +	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_NV_READ);
> +	if (rc)
> +		goto out_free;
> +
> +	while (copied < size) {
> +		tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_NV_READ);
> +
> +		tpm_buf_append_u32(&buf, TPM2_RH_OWNER);
> +		tpm_buf_append_u32(&buf, nvhandle);
> +
> +		auth_area.handle = cpu_to_be32(TPM2_RS_PW);
> +		auth_area.nonce_size = 0;
> +		auth_area.attributes = 0;
> +		auth_area.auth_size = 0;
> +
> +		tpm_buf_append_u32(&buf, sizeof(struct tpm2_null_auth_area));
> +		tpm_buf_append(&buf, (const unsigned char *)&auth_area,
> +			       sizeof(auth_area));
> +
> +		/* Size to request: at most 512 bytes at a time */
> +		tpm_buf_append_u16(&buf, min_t(u16, 512, size-copied));
> +		/* Offset: start at where we ended up */
> +		tpm_buf_append_u16(&buf, copied);
> +
> +		rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to read NV index");
> +		if (rc) {
> +			if (rc > 0)
> +				rc = -EIO;
> +			goto out_free;
> +		}
> +		resp_header_length = tpm_buf_response_header_length(&buf, 0);
> +		out = (struct tpm2_buffer_out *)&buf.data[resp_header_length];
> +		recd = be16_to_cpu(out->size);
> +
> +		if (recd == 0) {
> +			rc = -EIO;
> +			goto out_free;
> +		}
> +		if (recd > size-copied) {
> +			rc = -EIO;
> +			goto out_free;
> +		}

You could add this to the above.

if (recd == 0 || recd > size - copied) ...

This address the case where the TPM is actually returning more bytes 
than requested.

> +
> +		memcpy(*dest + copied, out->data, recd);
> +		copied += recd;
> +	};
> +
> +out_free:
> +	if ((rc < 0) || (copied != size)) {
> +		kvfree(*dest);


kfree ?


> +		*dest = NULL;
> +	}
> +
> +out:
> +	tpm_buf_destroy(&buf);
> +
> +	if (rc < 0)
> +		return rc;
> +	else if (copied != size)
> +		return -EIO;
> +	else
> +		return size;
> +}
> +
>   struct tpm2_get_random_out {
>   	__be16 size;
>   	u8 buffer[TPM_MAX_RNG_DATA];
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 8f4ff39f51e7..b812236b9955 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -53,6 +53,40 @@ struct tpm_bank_info {
>   	u16 crypto_id;
>   };
>   
> +enum tpm_nv_public_attrs {
> +	TPM2_ATTR_NV_PPWRITE = 0x00000001,
> +	TPM2_ATTR_NV_OWNERWRITE = 0x00000002,
> +	TPM2_ATTR_NV_AUTHWRITE = 0x00000004,
> +	TPM2_ATTR_NV_POLICYWRITE = 0x00000008,
> +	/* Bits 4-7 TPM_NT */
> +	/* Bits 8-9 reserved */
> +	TPM2_ATTR_NV_POLICY_DELETE = 0x00000400,
> +	TPM2_ATTR_NV_WRITELOCKED = 0x00000800,
> +	TPM2_ATTR_NV_WRITEALL = 0x00001000,
> +	TPM2_ATTR_NV_WRITE_DEFINE = 0x00002000,
> +	TPM2_ATTR_NV_WRITE_STCLEAR = 0x00004000,
> +	TPM2_ATTR_NV_GLOBALLOCK = 0x00008000,
> +	TPM2_ATTR_NV_PPREAD = 0x00010000,
> +	TPM2_ATTR_NV_OWNERREAD = 0x00020000,
> +	TPM2_ATTR_NV_AUTHREAD = 0x00040000,
> +	TPM2_ATTR_NV_POLICYREAD = 0x00080000,
> +	/* Bits 20-24 reserved */
> +	TPM2_ATTR_NV_NO_DA = 0x02000000,
> +	TPM2_ATTR_NV_ORDERLY = 0x04000000,
> +	TPM2_ATTR_NV_CLEAR_STCLEAR = 0x08000000,
> +	TPM2_ATTR_NV_READLOCKED = 0x10000000,
> +	TPM2_ATTR_NV_WRITTEN = 0x20000000,
> +	TPM2_ATTR_NV_PLATFORMCREATE = 0x40000000,
> +	TPM2_ATTR_NV_READ_STCLEAR = 0x80000000,
> +};
> +
> +struct tpm2_nv_public {
> +	u32 nv_index;
> +	u16 name_alg;
> +	u32 attributes;
> +	u16 data_size;
> +};
> +
>   enum TPM_OPS_FLAGS {
>   	TPM_OPS_AUTO_STARTUP = BIT(0),
>   };
> @@ -189,6 +223,10 @@ enum tpm2_structures {
>   	TPM2_ST_SESSIONS	= 0x8002,
>   };
>   
> +enum tpm2_root_handles {
> +	TPM2_RH_OWNER		= 0x40000001,
> +};
> +
>   /* Indicates from what layer of the software stack the error comes from */
>   #define TSS2_RC_LAYER_SHIFT	 16
>   #define TSS2_RESMGR_TPM_RC_LAYER (11 << TSS2_RC_LAYER_SHIFT)
> @@ -223,6 +261,7 @@ enum tpm2_command_codes {
>   	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
>   	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
>   	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
> +	TPM2_CC_NV_READPUBLIC		= 0x0169,
>   	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
>   	TPM2_CC_GET_CAPABILITY	        = 0x017A,
>   	TPM2_CC_GET_RANDOM	        = 0x017B,
> @@ -389,6 +428,21 @@ static inline void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
>   	tpm_buf_append(buf, (u8 *) &value2, 4);
>   }
>   
> +static inline u32 tpm_buf_response_header_length(struct tpm_buf *buf, bool has_shielded_locations)
> +{
> +	u32 header_length = TPM_HEADER_SIZE;
> +
> +	/* Possibly a handle for a Shielded Location */
> +	if (has_shielded_locations)
> +		header_length += 4;
> +
> +	/* Possibly the 32-bit parameter area size */
> +	if (tpm_buf_tag(buf) == TPM2_ST_SESSIONS)
> +		header_length += 4;
> +
> +	return header_length;
> +}
> +
>   static inline u32 tpm2_rc_value(u32 rc)
>   {
>   	return (rc & BIT(7)) ? rc & 0xff : rc;
> @@ -401,6 +455,7 @@ extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>   			struct tpm_digest *digest);
>   extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>   			  struct tpm_digest *digests);
> +extern int tpm_nv_read(struct tpm_chip *chip, u32 nv_idx, u32 *attrs_out, void **out);
>   extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
>   extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
>   extern struct tpm_chip *tpm_default_chip(void);
> @@ -423,6 +478,16 @@ static inline int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>   	return -ENODEV;
>   }
>   
> +static inline int tpm2_nv_readpublic(struct tpm_chip *chip, u32 nvindex, struct tpm2_nv_public *info)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int tpm_nv_read(struct tpm_chip *chip, u32 nv_idx, u8 *out, size_t max)
> +{


tpm2_nv_read


> +	return -ENODEV;
> +}
> +
>   static inline int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen)
>   {
>   	return -ENODEV;


