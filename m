Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 400FFE6312
	for <lists+linux-integrity@lfdr.de>; Sun, 27 Oct 2019 15:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfJ0Odk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Oct 2019 10:33:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4756 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726674AbfJ0Odk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Oct 2019 10:33:40 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9REVamU092102
        for <linux-integrity@vger.kernel.org>; Sun, 27 Oct 2019 10:33:39 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vw3nvwh4j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 27 Oct 2019 10:33:39 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 27 Oct 2019 14:33:37 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 27 Oct 2019 14:33:34 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9REXXtn49217670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 27 Oct 2019 14:33:33 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6767252050;
        Sun, 27 Oct 2019 14:33:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.187.251])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3E95F52054;
        Sun, 27 Oct 2019 14:33:32 +0000 (GMT)
Subject: Re: [PATCH v2 3/4] KEYS: Added BUILTIN_TRUSTED_KEYS enum to measure
 keys added to builtin_trusted_keys keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, casey@schaufler-ca.com, sashal@kernel.org,
        jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Date:   Sun, 27 Oct 2019 10:33:30 -0400
In-Reply-To: <20191023233950.22072-4-nramas@linux.microsoft.com>
References: <20191023233950.22072-1-nramas@linux.microsoft.com>
         <20191023233950.22072-4-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102714-0028-0000-0000-000003B00E4A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102714-0029-0000-0000-000024724822
Message-Id: <1572186810.4532.206.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910270152
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-10-23 at 16:39 -0700, Lakshmi Ramasubramanian wrote:
> Added an ima policy hook BUILTIN_TRUSTED_KEYS to measure keys added
> to builtin_trusted_keys keyring.
> 
> Added a helper function to check if the given keyring is
> the builtin_trusted_keys keyring.
> 
> Defined a function to map the keyring to ima policy hook function
> and use it when measuring the key.
 
.builtin_trusted_keys is a trusted keyring, which is created by the
kernel.  It cannot be deleted or replaced by userspace, so it should
be possible to correlate a keyring name with a keyring number on
policy load.

Other examples of trusted keyrings are: .ima, .evm, .platform,
.blacklist, .builtin_regdb_keys.  Instead of defining a keyring
specific method of getting the keyring number, define a generic
method.  For example, the userspace command "keyctl describe
%keyring:.builtin_trusted_keys" searches /proc/keys, but the kernel
shouldn't need to access /proc/keys.

> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  Documentation/ABI/testing/ima_policy |  1 +
>  certs/system_keyring.c               |  5 +++++
>  include/keys/system_keyring.h        |  2 ++
>  security/integrity/ima/ima.h         |  2 ++
>  security/integrity/ima/ima_api.c     |  1 +
>  security/integrity/ima/ima_main.c    | 25 +++++++++++++++++++++++--
>  security/integrity/ima/ima_queue.c   |  2 +-
>  7 files changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index fc376a323908..25566c74e679 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -29,6 +29,7 @@ Description:
>  				[FIRMWARE_CHECK]
>  				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
>  				[KEXEC_CMDLINE]
> +				[BUILTIN_TRUSTED_KEYS]

The .builtin_trusted_keys is the name of a keyring, not of an IMA
hook.  Define a new IMA policy "keyring=" option, where keyring is
optional.  Some IMA policy rules might look like:

# measure all keys
measure func=KEYRING_CHECK

# measure keys on the IMA keyring
measure func=KEYRING_CHECK keyring=".ima"

# measure keys on the BUILTIN and IMA keyrings into a different PCR
measure func=KEYRING_CHECK keyring=".builtin_trusted_keys|.ima" pcr=11


>  			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
>  			       [[^]MAY_EXEC]
>  			fsmagic:= hex value
> 
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index bce430b3386e..986f80eead4d 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -605,6 +605,24 @@ int ima_load_data(enum kernel_load_data_id id)
>  	return 0;
>  }
>  
> +/*
> + * Maps the given keyring to a IMA Hook.
> + * @keyring: A keyring to which a key maybe linked to.
> + *
> + * This function currently handles only builtin_trusted_keys.
> + * To handle more keyrings, this function, ima hook and
> + * ima policy handler need to be updated.
> + */
> +static enum ima_hooks keyring_policy_map(struct key *keyring)
> +{
> +	enum ima_hooks func = NONE;
> +
> +	if (is_builtin_trusted_keyring(keyring))
> +		func = BUILTIN_TRUSTED_KEYS;
> +
> +	return func;
> +}
> +
>  /*
>   * process_buffer_measurement - Measure the buffer to ima log.
>   * @buf: pointer to the buffer that needs to be added to the log.
> @@ -706,19 +724,22 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
>  				   unsigned long flags, bool create)
>  {
>  	const struct public_key *pk;
> +	enum ima_hooks func;
>  
>  	if (key->type != &key_type_asymmetric)
>  		return;
>  
> +	func = keyring_policy_map(keyring);
> +

"func", in this case, should be something like "KEYRING_CHECK".  No
mapping is necessary.

>  	if (!ima_initialized) {
> -		ima_queue_key_for_measurement(key, NONE);
> +		ima_queue_key_for_measurement(key, func);
>  		return;
>  	}
>  
>  	pk = key->payload.data[asym_crypto];
>  	process_buffer_measurement(pk->key, pk->keylen,
>  				   key->description,
> -				   NONE, 0);
> +				   func, 0);

Pass the "keyring" to process_buffer_measurement() and on to
ima_get_action(), so that ima_get_action() determines whether the
keyring is in policy.

Mimi

>  }
>  

