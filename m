Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30D501B758
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2019 15:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfEMNsu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 May 2019 09:48:50 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32936 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726866AbfEMNsu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 May 2019 09:48:50 -0400
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 65A5126E812FC56628AA;
        Mon, 13 May 2019 14:48:46 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.36) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 13 May
 2019 14:48:42 +0100
Subject: Re: [PATCH 2/3 v5] add a new template field buf to contain the buffer
To:     Prakhar Srivastava <prsriva02@gmail.com>,
        <linux-integrity@vger.kernel.org>,
        <inux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zohar@linux.ibm.com>, <ebiederm@xmission.com>,
        <vgoyal@redhat.com>, <prsriva@microsoft.com>
References: <20190510223744.10154-1-prsriva02@gmail.com>
 <20190510223744.10154-3-prsriva02@gmail.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <45344b2f-d9ea-f7df-e45f-18037e2ba5ca@huawei.com>
Date:   Mon, 13 May 2019 15:48:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190510223744.10154-3-prsriva02@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/11/2019 12:37 AM, Prakhar Srivastava wrote:
> From: Prakhar Srivastava <prsriva02@gmail.com>
> 
> The buffer(cmdline args) added to the ima log cannot be attested
> without having the actual buffer. Thus to make the measured buffer
> available to stroe/read a new ima temaplate (buf) is added.

Hi Prakhar

please fix the typos. More comments below.


> The cmdline args used for soft reboot can then be read and attested
> later.
> 
> The patch adds a new template field buf to store/read the buffer
> used while measuring kexec_cmdline args in the
> [PATCH 1/2 v5]: "add a new ima hook and policy to measure the cmdline".
> Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
> ---
>   security/integrity/ima/ima_main.c         | 23 +++++++++++++++++++++++
>   security/integrity/ima/ima_template.c     |  2 ++
>   security/integrity/ima/ima_template_lib.c | 21 +++++++++++++++++++++
>   security/integrity/ima/ima_template_lib.h |  4 ++++
>   security/integrity/integrity.h            |  1 +
>   5 files changed, 51 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 1d186bda25fe..ca12885ca241 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -605,10 +605,32 @@ static int process_buffer_measurement(const void *buf, int size,
>   	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
>   	int action = 0;
>   
> +	struct buffer_xattr {
> +		enum evm_ima_xattr_type type;
> +		u16 buf_length;
> +		unsigned char buf[0];
> +	};
> +	struct buffer_xattr *buffer_event_data = NULL;
> +	int alloc_length = 0;
> +
>   	action = ima_get_action(NULL, cred, secid, 0, KEXEC_CMDLINE, &pcr);
>   	if (!(action & IMA_AUDIT) && !(action & IMA_MEASURE))
>   		goto out;
>   
> +	alloc_length = sizeof(struct buffer_xattr) + size;
> +	buffer_event_data = kzalloc(alloc_length, GFP_KERNEL);
> +	if (!buffer_event_data) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	buffer_event_data->type = IMA_XATTR_BUFFER;
> +	buffer_event_data->buf_length = size;
> +	memcpy(buffer_event_data->buf, buf, size);
> +
> +	event_data.xattr_value = (struct evm_ima_xattr_data *)buffer_event_data;
> +	event_data.xattr_len = alloc_length;

I would prefer that you introduce two new fields in the ima_event_data
structure. You can initialize them directly with the parameters of
process_buffer_measurement(). ima_write_template_field_data() will make
a copy.


> +
>   	memset(iint, 0, sizeof(*iint));
>   	memset(&hash, 0, sizeof(hash));
>   
> @@ -638,6 +660,7 @@ static int process_buffer_measurement(const void *buf, int size,
>   	}
>   
>   out:
> +	kfree(buffer_event_data);
>   	return ret;
>   }
>   
> diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
> index b631b8bc7624..a76d1c04162a 100644
> --- a/security/integrity/ima/ima_template.c
> +++ b/security/integrity/ima/ima_template.c
> @@ -43,6 +43,8 @@ static const struct ima_template_field supported_fields[] = {
>   	 .field_show = ima_show_template_string},
>   	{.field_id = "sig", .field_init = ima_eventsig_init,
>   	 .field_show = ima_show_template_sig},
> +	{.field_id = "buf", .field_init = ima_eventbuf_init,
> +	 .field_show = ima_show_template_buf},

Please update Documentation/security/IMA-templates.rst

Thanks

Roberto


>   };
>   #define MAX_TEMPLATE_NAME_LEN 15
>   
> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
> index 513b457ae900..95a827f42c18 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> @@ -162,6 +162,11 @@ void ima_show_template_sig(struct seq_file *m, enum ima_show_type show,
>   	ima_show_template_field_data(m, show, DATA_FMT_HEX, field_data);
>   }
>   
> +void ima_show_template_buf(struct seq_file *m, enum ima_show_type show,
> +				struct ima_field_data *field_data)
> +{
> +	ima_show_template_field_data(m, show, DATA_FMT_HEX, field_data);
> +}
>   /**
>    * ima_parse_buf() - Parses lengths and data from an input buffer
>    * @bufstartp:       Buffer start address.
> @@ -389,3 +394,19 @@ int ima_eventsig_init(struct ima_event_data *event_data,
>   	return ima_write_template_field_data(xattr_value, event_data->xattr_len,
>   					     DATA_FMT_HEX, field_data);
>   }
> +
> +/*
> + *  ima_eventbuf_init - include the buffer(kexec-cmldine) as part of the
> + *  template data.
> + */
> +int ima_eventbuf_init(struct ima_event_data *event_data,
> +				struct ima_field_data *field_data)
> +{
> +	struct evm_ima_xattr_data *xattr_value = event_data->xattr_value;
> +
> +	if ((!xattr_value) || (xattr_value->type != IMA_XATTR_BUFFER))
> +		return 0;
> +
> +	return ima_write_template_field_data(xattr_value, event_data->xattr_len,
> +					DATA_FMT_HEX, field_data);
> +}
> diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
> index 6a3d8b831deb..12f1a8578b31 100644
> --- a/security/integrity/ima/ima_template_lib.h
> +++ b/security/integrity/ima/ima_template_lib.h
> @@ -29,6 +29,8 @@ void ima_show_template_string(struct seq_file *m, enum ima_show_type show,
>   			      struct ima_field_data *field_data);
>   void ima_show_template_sig(struct seq_file *m, enum ima_show_type show,
>   			   struct ima_field_data *field_data);
> +void ima_show_template_buf(struct seq_file *m, enum ima_show_type show,
> +			   struct ima_field_data *field_data);
>   int ima_parse_buf(void *bufstartp, void *bufendp, void **bufcurp,
>   		  int maxfields, struct ima_field_data *fields, int *curfields,
>   		  unsigned long *len_mask, int enforce_mask, char *bufname);
> @@ -42,4 +44,6 @@ int ima_eventname_ng_init(struct ima_event_data *event_data,
>   			  struct ima_field_data *field_data);
>   int ima_eventsig_init(struct ima_event_data *event_data,
>   		      struct ima_field_data *field_data);
> +int ima_eventbuf_init(struct ima_event_data *event_data,
> +		      struct ima_field_data *field_data);
>   #endif /* __LINUX_IMA_TEMPLATE_LIB_H */
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 7de59f44cba3..14ef904f091d 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -74,6 +74,7 @@ enum evm_ima_xattr_type {
>   	EVM_IMA_XATTR_DIGSIG,
>   	IMA_XATTR_DIGEST_NG,
>   	EVM_XATTR_PORTABLE_DIGSIG,
> +	IMA_XATTR_BUFFER,
>   	IMA_XATTR_LAST
>   };
>   
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
