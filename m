Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA551F3F9F
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jun 2020 17:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgFIPk7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Jun 2020 11:40:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31764 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728533AbgFIPk6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Jun 2020 11:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591717256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LbakoApcQMOzerLqCbKPiBPY6nfZuVjgD6lCDNANLkI=;
        b=fEOr9WxEWiutkRrv3NfuEDuxcSc3X6ODty8By5QISlRLYRo6JGz4yIEEfB/2GCVUJeWNJ8
        jr4yI7U1AD41ZdlgfS44Lt1X8sRzRmlAuatnSV6yDjV+/NAuFIR/9gij3YRcYliRw4Q+aT
        rLLbzpkAvMyl74PlzNTGyHVhrQpE3C4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-mHm-sxitPCao0hmQ4aZKHw-1; Tue, 09 Jun 2020 11:40:54 -0400
X-MC-Unique: mHm-sxitPCao0hmQ4aZKHw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6CE5461;
        Tue,  9 Jun 2020 15:40:53 +0000 (UTC)
Received: from x2.localnet (ovpn-113-152.phx2.redhat.com [10.3.113.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD4658203A;
        Tue,  9 Jun 2020 15:40:49 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-audit@redhat.com
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        zohar@linux.ibm.com, paul@paul-moore.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] IMA: Add audit log for failure conditions
Date:   Tue, 09 Jun 2020 11:40:49 -0400
Message-ID: <27448076.Og45N0Lxmj@x2>
Organization: Red Hat
In-Reply-To: <20200608215343.4491-1-nramas@linux.microsoft.com>
References: <20200608215343.4491-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Monday, June 8, 2020 5:53:43 PM EDT Lakshmi Ramasubramanian wrote:
> The final log statement in process_buffer_measurement() for failure
> condition is at debug level. This does not log the message unless
> the system log level is raised which would significantly increase
> the messages in the system log. Change this log message to an audit
> message for better triaging failures in the function.
> 
> ima_alloc_key_entry() does not log a message for failure condition.
> Add an audit message for failure condition in this function.
> 
> Sample audit messages:

Wouldn't it be better to have an IMA_ERROR record type?

> [    8.051937] audit: type=1804 audit(1591633422.365:8): pid=1 uid=0
> auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0
> op=measuring_keys cause=hashing_error(-22) 

The audit system uses a name=value scheme to express information. This last 
field has something in parenthesis that may need to be interpreted. In its 
current form, we can't do this. It would require writing code to special case 
this event, go to this field, find the first parenthesis, find the second, 
extract what's between, and look it up.

It would be better if that number in parenthesis was normalized to the 
expected way we do audit events so nothing special has to be made.

-Steve


> comm="systemd"
> name=".builtin_trusted_keys" res=0
> 
> [    8.063218] audit: type=1804 audit(1591633422.377:9): pid=1 uid=0
> auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0
> op=measuring_kexec_cmdline cause=alloc_entry(-12) comm="systemd"
> name="kexec-cmdline" res=0
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  security/integrity/ima/ima.h            |  2 ++
>  security/integrity/ima/ima_main.c       | 37 +++++++++++++++++++++----
>  security/integrity/ima/ima_queue.c      |  2 --
>  security/integrity/ima/ima_queue_keys.c |  4 +++
>  4 files changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index df93ac258e01..8a47249c6238 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -47,6 +47,8 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8 };
> 
>  #define NR_BANKS(chip) ((chip != NULL) ? chip->nr_allocated_banks : 0)
> 
> +#define AUDIT_CAUSE_LEN_MAX 32
> +
>  /* current content of the policy */
>  extern int ima_policy_flag;
> 
> diff --git a/security/integrity/ima/ima_main.c
> b/security/integrity/ima/ima_main.c index 800fb3bba418..b10f09bc7eca
> 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -739,6 +739,9 @@ void process_buffer_measurement(const void *buf, int
> size, int pcr, const char *keyring)
>  {
>  	int ret = 0;
> +	const char *audit_cause = "ENOMEM";
> +	const char *op = "measuring_keys";
> +	char measurement_audit_cause[AUDIT_CAUSE_LEN_MAX];
>  	struct ima_template_entry *entry = NULL;
>  	struct integrity_iint_cache iint = {};
>  	struct ima_event_data event_data = {.iint = &iint,
> @@ -793,21 +796,43 @@ void process_buffer_measurement(const void *buf, int
> size, iint.ima_hash->length = hash_digest_size[ima_hash_algo];
> 
>  	ret = ima_calc_buffer_hash(buf, size, iint.ima_hash);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		audit_cause = "hashing_error";
>  		goto out;
> +	}
> 
>  	ret = ima_alloc_init_template(&event_data, &entry, template);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		audit_cause = "alloc_entry";
>  		goto out;
> +	}
> 
>  	ret = ima_store_template(entry, violation, NULL, buf, pcr);
> -
> -	if (ret < 0)
> +	if (ret < 0) {
> +		audit_cause = "store_entry";
>  		ima_free_template_entry(entry);
> +	}
> 
>  out:
> -	if (ret < 0)
> -		pr_devel("%s: failed, result: %d\n", __func__, ret);
> +	if (ret < 0) {
> +		snprintf(measurement_audit_cause, AUDIT_CAUSE_LEN_MAX,
> +			 "%s(%d)", audit_cause, ret);
> +
> +		switch (func) {
> +		case KEXEC_CMDLINE:
> +			op = "measuring_kexec_cmdline";
> +			break;
> +		case KEY_CHECK:
> +			op = "measuring_keys";
> +			break;
> +		default:
> +			op = "measuring_blacklisted_hash";
> +			break;
> +		}
> +
> +		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, eventname,
> +				    op, measurement_audit_cause, ret, 0);
> +	}
> 
>  	return;
>  }
> diff --git a/security/integrity/ima/ima_queue.c
> b/security/integrity/ima/ima_queue.c index fb4ec270f620..4a761d765c6c
> 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -19,8 +19,6 @@
>  #include <linux/slab.h>
>  #include "ima.h"
> 
> -#define AUDIT_CAUSE_LEN_MAX 32
> -
>  /* pre-allocated array of tpm_digest structures to extend a PCR */
>  static struct tpm_digest *digests;
> 
> diff --git a/security/integrity/ima/ima_queue_keys.c
> b/security/integrity/ima/ima_queue_keys.c index cb3e3f501593..4de31ff172aa
> 100644
> --- a/security/integrity/ima/ima_queue_keys.c
> +++ b/security/integrity/ima/ima_queue_keys.c
> @@ -68,6 +68,7 @@ static struct ima_key_entry *ima_alloc_key_entry(struct
> key *keyring, size_t payload_len)
>  {
>  	int rc = 0;
> +	const char *audit_cause = "ENOMEM";
>  	struct ima_key_entry *entry;
> 
>  	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> @@ -88,6 +89,9 @@ static struct ima_key_entry *ima_alloc_key_entry(struct
> key *keyring,
> 
>  out:
>  	if (rc) {
> +		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL,
> +				    keyring->description, "measuring_keys",
> +				    audit_cause, rc, 0);
>  		ima_free_key_entry(entry);
>  		entry = NULL;
>  	}




