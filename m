Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C745FD84D7
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Oct 2019 02:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfJPAam (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Oct 2019 20:30:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727579AbfJPAam (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Oct 2019 20:30:42 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9G0QvSe048675
        for <linux-integrity@vger.kernel.org>; Tue, 15 Oct 2019 20:30:41 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vnkhf8rxn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 15 Oct 2019 20:30:41 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 16 Oct 2019 01:30:38 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Oct 2019 01:30:35 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9G0UYEL37683290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 00:30:34 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33D494203F;
        Wed, 16 Oct 2019 00:30:34 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDF1A42047;
        Wed, 16 Oct 2019 00:30:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.156.20])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Oct 2019 00:30:32 +0000 (GMT)
Subject: Re: [PATCH v0 1/1] KEYS: LSM Hook for key_create_or_update
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, sashal@kernel.org,
        jamorris@linux.microsoft.com, kgoldman@us.ibm.com,
        mjg59@google.com, dhowells@redhat.com
Cc:     balajib@linux.microsoft.com, prsriva@linux.microsoft.com,
        jorhand@linux.microsoft.com, patatash@linux.microsoft.com
Date:   Tue, 15 Oct 2019 20:30:32 -0400
In-Reply-To: <20191015231750.25992-2-nramas@linux.microsoft.com>
References: <20191015231750.25992-1-nramas@linux.microsoft.com>
         <20191015231750.25992-2-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19101600-0016-0000-0000-000002B8637E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101600-0017-0000-0000-0000331983DB
Message-Id: <1571185832.5250.153.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910160000
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-10-15 at 16:17 -0700, Lakshmi Ramasubramanian wrote:
> Add a LSM Hook for key_create_or_update function. The motive behind
> this change is enable subsystems to receive notification when
> a new key is created or updated.

As per Documentation/process/submitting-patches.rst section "2)
Describe your changes", please begin the patch description by
describing the problem.

> 
> IMA will be one of the subsystems that will use this hook to measure
> the newly created key.
> 
> This change set includes helper functions to check if the keyring
> (to which a new key is being added, for example) is one of 
> the trusted keys keyring (builtin, secondary, or platform).
> 
> The change set also includes an IMA function that will be called
> from the LSM hook to notify of the newly created key and the keyring
> to which the key is being added to.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

This patch should be broken up even further.[1]  In this case to
simplify review, separate defining the new LSM hook from any IMA code.
 Different maintainers need to Ack/sign off on these patches.

The new LSM hook patch, with a clear well written patch description,
should be posted on the LSM mailing list as well.

[1] Refer to Documentation/process/submitting-patches.rst section 3)
"Separate your changes". 
  
> ---
>  certs/system_keyring.c            | 23 +++++++++++++++++++++++
>  include/keys/system_keyring.h     |  4 ++++
>  include/linux/ima.h               |  8 ++++++++
>  include/linux/lsm_hooks.h         | 14 ++++++++++++++
>  include/linux/security.h          | 10 ++++++++++
>  security/integrity/ima/ima.h      |  1 +
>  security/integrity/ima/ima_main.c | 19 +++++++++++++++++++
>  security/keys/key.c               |  8 ++++++++
>  security/security.c               | 11 +++++++++++
>  9 files changed, 98 insertions(+)
> 
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 1eba08a1af82..a89d23fb5d9d 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -283,3 +283,26 @@ void __init set_platform_trusted_keys(struct key *keyring)
>  	platform_trusted_keys = keyring;
>  }
>  #endif
> +
> +inline bool is_builtin_trusted_keyring(struct key *keyring)
> +{
> +	return (keyring == builtin_trusted_keys);
> +}
> +
> +inline bool is_secondary_trusted_keyring(struct key *keyring)
> +{
> +	#ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
> +	return (keyring == secondary_trusted_keys);
> +	#else
> +	return false;
> +	#endif
> +}
> +
> +inline bool is_platform_trusted_keyring(struct key *keyring)
> +{
> +	#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> +	return (keyring == platform_trusted_keys);
> +	#else
> +	return false;
> +	#endif
> +}

Why are these functions defined in a new LSM hook patch?  Before
posting a patch, please review the patch line by line, making sure
that there isn't anything extraneous.

> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
> index c1a96fdf598b..2517181d8d6c 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -66,4 +66,8 @@ static inline void set_platform_trusted_keys(struct key *keyring)
>  }
>  #endif
>  
> +extern bool is_builtin_trusted_keyring(struct key *keyring);
> +extern bool is_secondary_trusted_keyring(struct key *keyring);
> +extern bool is_platform_trusted_keyring(struct key *keyring);
> +

Not needed in this patch.

Mimi

