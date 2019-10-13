Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7419ED53D4
	for <lists+linux-integrity@lfdr.de>; Sun, 13 Oct 2019 04:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfJMCt3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 12 Oct 2019 22:49:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51290 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727606AbfJMCt3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 12 Oct 2019 22:49:29 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9D2kvef165792
        for <linux-integrity@vger.kernel.org>; Sat, 12 Oct 2019 22:49:27 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vkp1fekf3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sat, 12 Oct 2019 22:49:27 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 13 Oct 2019 03:49:25 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 13 Oct 2019 03:49:22 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9D2nKdn56623234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Oct 2019 02:49:21 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCDD4A4055;
        Sun, 13 Oct 2019 02:49:20 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A35CA4040;
        Sun, 13 Oct 2019 02:49:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.192.114])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 13 Oct 2019 02:49:19 +0000 (GMT)
Subject: Re: [PATCH v0 1/2] KEYS: Measure keys added to builtin or secondary
 trusted keys keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, sashal@kernel.org,
        jamorris@linux.microsoft.com, kgoldman@us.ibm.com,
        mjg59@google.com, dhowells@redhat.com
Cc:     balajib@linux.microsoft.com, prsriva@linux.microsoft.com,
        jorhand@linux.microsoft.com, patatash@linux.microsoft.com
Date:   Sat, 12 Oct 2019 22:49:18 -0400
In-Reply-To: <20191011173547.3200-2-nramas@linux.microsoft.com>
References: <20191011173547.3200-1-nramas@linux.microsoft.com>
         <20191011173547.3200-2-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19101302-0028-0000-0000-000003A98D4C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101302-0029-0000-0000-0000246B9C45
Message-Id: <1570934958.5250.121.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-12_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910130026
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-10-11 at 10:35 -0700, Lakshmi Ramasubramanian wrote:
> IMA hook TRUSTED_KEYS to measure keys added to builtin or secondary
> trusted keys keyring. This can be enabled through IMA policy.
> 
> The key data is queued up if IMA is not yet initialized and measured
> when IMA is initialized. If IMA is initialized then the key is
> measured immediately.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

This patch needs to be broken up into multiple, smaller patches.  As
discussed, measuring keys should be separate from the early
measurement workqueue, at minimum as separate patches, if not separate
patch sets.  A new LSM hook definitely needs to be defined in a
separate patch.

>  /*
> - * process_buffer_measurement - Measure the buffer to ima log.
> - * @buf: pointer to the buffer that needs to be added to the log.
> - * @size: size of buffer(in bytes).
> - * @eventname: event name to be used for the buffer entry.
> - * @cred: a pointer to a credentials structure for user validation.
> - * @secid: the secid of the task to be validated.
> + * ima_post_key_create_or_update
> + *     @keyring points to the keyring to which the key belongs
> + *     @key points to the key being created or updated
> + *     @builtin_or_secondary flag indicating whether
> + *     the keyring to which the key belongs is the builtin
> + *     or secondary trusted keys keyring
> + * Measure keys added to the builtin or secondary trusted keyring
>   *
> - * Based on policy, the buffer is measured into the ima log.
> + * On success return 0.
> + * Return appropriate error code on error
>   */
> -static void process_buffer_measurement(const void *buf, int size,
> -				       const char *eventname,
> -				       const struct cred *cred, u32 secid)
> +int ima_post_key_create_or_update(struct key *keyring,
> +				  struct key *key,
> +				  bool builtin_or_secondary)
>  {
> -	int ret = 0;
> -	struct ima_template_entry *entry = NULL;
> -	struct integrity_iint_cache iint = {};
> -	struct ima_event_data event_data = {.iint = &iint,
> -					    .filename = eventname,
> -					    .buf = buf,
> -					    .buf_len = size};
> -	struct ima_template_desc *template_desc = NULL;
> -	struct {
> -		struct ima_digest_data hdr;
> -		char digest[IMA_MAX_DIGEST_SIZE];
> -	} hash = {};
> -	int violation = 0;
> -	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
> -	int action = 0;
> +	int rc = 0;
> +	struct ima_trusted_key_entry *entry = NULL;
> +	const struct public_key *pk;
> +	u32 secid;
> +	bool queued = false;
>  
> -	action = ima_get_action(NULL, cred, secid, 0, KEXEC_CMDLINE, &pcr,
> -				&template_desc);
> -	if (!(action & IMA_MEASURE))
> -		return;
> +	/*
> +	 * We only measure asymmetric keys added to either
> +	 * the builtin or the secondary trusted keys keyring.
> +	 */
> +	if (!builtin_or_secondary ||
> +	    (key->type != &key_type_asymmetric))
> +		return 0;

Measuring keys should be generic, independent of the keyring that it
is being added to.  Please do not hard code policy.

Mimi

>  
> -	iint.ima_hash = &hash.hdr;
> -	iint.ima_hash->algo = ima_hash_algo;
> -	iint.ima_hash->length = hash_digest_size[ima_hash_algo];
> +	mutex_lock(&ima_trusted_keys_mutex);

