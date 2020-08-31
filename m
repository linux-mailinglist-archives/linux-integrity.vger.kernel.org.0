Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914A5257F31
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Aug 2020 19:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgHaRDN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Aug 2020 13:03:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59704 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728418AbgHaRDM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Aug 2020 13:03:12 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07VH1uUs017762;
        Mon, 31 Aug 2020 13:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=A4B2a9+fgKjB2GfXhrEpVQFgQTELQDJKb0sN6gsP0Ss=;
 b=g0T45vqHswIrTRR0qxOK4mB2BnzQUmIw40fTIDoytBNg9VEOzF2YVyYO4FnJiZLwfotr
 bC1uBpAI92bNS+9LJYMRf4JNn1cb/4/S5LEGwFwDvM61h7lAQqOwBtEDK1jEjDQc1iSj
 LuWitgGqdMfMOmRMCPeFa2JtVtCQ5fUHhy5QHP8AVQl+Woat0PEEPW4W6PcrxN0gmPMl
 tdEADHm0gWh5gxX/Pkv6bAeGFYNkRRvt+N3DqKol1+D74qTgh95vIlqsAmsOXsSA2WJW
 AQXVQk8E16gNay7kI37HISYWlg4h4fGw+ftES45CaJifqAuMNIxn++Kj2Yiyl6KIsGwD lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3393sutn1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Aug 2020 13:03:05 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07VH2SDP023355;
        Mon, 31 Aug 2020 13:03:05 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3393sutmyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Aug 2020 13:03:05 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07VGxDRK021536;
        Mon, 31 Aug 2020 17:03:03 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 337en8ac3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Aug 2020 17:03:03 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07VH30Uq12058924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Aug 2020 17:03:01 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C950311C058;
        Mon, 31 Aug 2020 17:03:00 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD72511C05B;
        Mon, 31 Aug 2020 17:02:57 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.2.129])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 31 Aug 2020 17:02:57 +0000 (GMT)
Message-ID: <f11dbfc1382e60c04fdd519ce5122239fa0cab8b.camel@linux.ibm.com>
Subject: Re: [PATCH v3 3/6] IMA: update process_buffer_measurement to
 measure buffer hash
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Mon, 31 Aug 2020 13:02:56 -0400
In-Reply-To: <20200828015704.6629-4-tusharsu@linux.microsoft.com>
References: <20200828015704.6629-1-tusharsu@linux.microsoft.com>
         <20200828015704.6629-4-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-31_08:2020-08-31,2020-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310099
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-08-27 at 18:57 -0700, Tushar Sugandhi wrote:
> process_buffer_measurement() currently only measures the input buffer.
> When the buffer being measured is too large, it may result in bloated
> IMA logs.

The subject of  this sentence refers to an individual record, while
"bloated" refers to the measurement list.  A "bloated" measurement list
would contain too many or unnecessary records.  Your concern seems to
be with the size of the individual record, not the number of
measurement list entries.

Measuring the hash of the buffer data is similar to measuring the file
data.  In the case of the file data, however, the attestation server
may rely on a white list manifest/DB or the file signature to verify
the file data hash.  For buffer measurements, how will the attestation
server ascertain what is a valid buffer hash?

Hint:  I assume, correct me if I'm wrong, the measurement list record
template data is not meant to be verified, but used to detect if the "critical data" changed.

Please update the patch description accordingly.

> 
> Introduce a boolean parameter measure_buf_hash to support measuring
> hash of a buffer, which would be much smaller, instead of the buffer
> itself.
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---

<snip>

> +++ b/security/integrity/ima/ima_main.c
> @@ -733,17 +733,21 @@ int ima_load_data(enum kernel_load_data_id id)
>   * @func: IMA hook
>   * @pcr: pcr to extend the measurement
>   * @func_data: private data specific to @func, can be NULL.
> + * @measure_buf_hash: if set to true - will measure hash of the buf,
> + *                    instead of buf
>   *
>   * Based on policy, the buffer is measured into the ima log.
>   */
>  int process_buffer_measurement(struct inode *inode, const void *buf, int size,
>  			       const char *eventname, enum ima_hooks func,
> -			       int pcr, const char *func_data)
> +			       int pcr, const char *func_data,
> +			       bool measure_buf_hash)
>  {
>  	int ret = 0;
>  	const char *audit_cause = "ENOMEM";
>  	struct ima_template_entry *entry = NULL;
>  	struct integrity_iint_cache iint = {};
> +	struct integrity_iint_cache digest_iint = {};
>  	struct ima_event_data event_data = {.iint = &iint,
>  					    .filename = eventname,
>  					    .buf = buf,
> @@ -752,7 +756,7 @@ int process_buffer_measurement(struct inode *inode, const void *buf, int size,
>  	struct {
>  		struct ima_digest_data hdr;
>  		char digest[IMA_MAX_DIGEST_SIZE];
> -	} hash = {};
> +	} hash = {}, digest_hash = {};
>  	int violation = 0;
>  	int action = 0;
>  	u32 secid;
> @@ -801,6 +805,24 @@ int process_buffer_measurement(struct inode *inode, const void *buf, int size,
>  		goto out;
>  	}
>  
> +	if (measure_buf_hash) {
> +		digest_iint.ima_hash = &digest_hash.hdr;
> +		digest_iint.ima_hash->algo = ima_hash_algo;
> +		digest_iint.ima_hash->length = hash_digest_size[ima_hash_algo];
> +
> +		ret = ima_calc_buffer_hash(hash.hdr.digest,
> +					   iint.ima_hash->length,
> +					   digest_iint.ima_hash);
> +		if (ret < 0) {
> +			audit_cause = "digest_hashing_error";
> +			goto out;
> +		}
> +
> +		event_data.iint = &digest_iint;
> +		event_data.buf = hash.hdr.digest;
> +		event_data.buf_len = iint.ima_hash->length;
> +	}
> +

There seems to be some code and variable duplication by doing it this
way.  Copying the caluclated buffer data hash to a temporary buffer
might eliminate it.

>  	ret = ima_alloc_init_template(&event_data, &entry, template);
>  	if (ret < 0) {
>  		audit_cause = "alloc_entry";

