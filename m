Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5BB4591A7
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Nov 2021 16:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239918AbhKVPyq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Nov 2021 10:54:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20206 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231714AbhKVPyp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Nov 2021 10:54:45 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMFCZbM018481;
        Mon, 22 Nov 2021 15:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=OBJC4YXHaOSL0/NtF92tKECm1NAnOoXcRD7rwv18+zg=;
 b=HHgdHpdfxtzZBOCMoDFMSLQbNUPC3CfvlQysWlWAbnQsJAaWxM7aBJjUnf/6D1Apors8
 VMbPXa+b9EV5VP8NahWSSpBeHZcs6CF9wxjlBWgOgM1EdW35g+UsNWgBJ8qQqYD5FWtd
 s5XHPTdTOaIfFcnu2jEfETDPlFPkcVfs1uLbE+bv/s1j08WSCaJCh6a0mxaJdDKIgF2a
 grUqkNrf/xSSvGyCDBJ2Jjb2oxBN8Ask7DO6gYxCx5esCjLkUNRXwgxz3+d5bpoJDEuZ
 ntm9gNWjFHHY/hb2nJCTU3Sm0nkLqPyrWZ7TlXn+OGzH2SzqhzTsvoL3XpeSFQ0/6TDB wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cgdn10wbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 15:51:34 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AMFUD65002578;
        Mon, 22 Nov 2021 15:51:33 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cgdn10wae-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 15:51:33 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AMFMuh6021202;
        Mon, 22 Nov 2021 15:36:46 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3cern9qwsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 15:36:45 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AMFahgN16777556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 15:36:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98471AE055;
        Mon, 22 Nov 2021 15:36:43 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 809FFAE051;
        Mon, 22 Nov 2021 15:36:42 +0000 (GMT)
Received: from sig-9-65-91-201.ibm.com (unknown [9.65.91.201])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Nov 2021 15:36:42 +0000 (GMT)
Message-ID: <9b414c36080138ac2862b9d6c24dfd98b7ccf974.camel@linux.ibm.com>
Subject: Re: [PATCH v4 2/2] integrity: support including firmware
 ".platform" keys at build time
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, jarkko@kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Seth Forshee <seth@forshee.me>
Date:   Mon, 22 Nov 2021 10:36:41 -0500
In-Reply-To: <20211111002057.123741-3-nayna@linux.ibm.com>
References: <20211111002057.123741-1-nayna@linux.ibm.com>
         <20211111002057.123741-3-nayna@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GsZ93kKRGic-zGX_fwDLkS4mLLSWdLam
X-Proofpoint-GUID: 1AmcxhbxIX0GJyO1lUHSjNQeHsUeZd_A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-22_08,2021-11-22_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1011 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111220081
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-11-10 at 19:20 -0500, Nayna Jain wrote:

> diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
> index 71f0177e8716..b2009b792882 100644
> --- a/security/integrity/Kconfig
> +++ b/security/integrity/Kconfig
> @@ -62,6 +62,16 @@ config INTEGRITY_PLATFORM_KEYRING
>           provided by the platform for verifying the kexec'ed kerned image
>           and, possibly, the initramfs signature.
>  
> +config INTEGRITY_PLATFORM_BUILTIN_KEYS

With the ".builtin_trusted_keys" keyring, using the word "BUILTIN" here
could be confusing.  Instead, similar to SYSTEM_TRUSTED_KEYRING and
SYSTEM_TRUSTED_KEYS, this config should be named
INTEGRITY_PLATFORM_KEYS.

> +        string "Builtin X.509 keys for .platform keyring"
> +        depends on KEYS
> +        depends on ASYMMETRIC_KEY_TYPE
> +        depends on INTEGRITY_PLATFORM_KEYRING
> +        help
> +          If set, this option should be the filename of a PEM-formatted file
> +          containing X.509 certificates to be loaded onto the ".platform"
> +          keyring.
> +

> 
> @@ -37,6 +41,28 @@ void __init add_to_platform_keyring(const char *source, const void *data,
>  		pr_info("Error adding keys to platform keyring %s\n", source);
>  }
>  
> +static __init int load_builtin_platform_cert(void)

Similarly, this should be named load_platform_cert_list() or
load_platform_certificate_list().

> +{
> +	const u8 *p;
> +	unsigned long size;
> +	int rc;
> +	struct key *keyring;
> +
> +	p = platform_certificate_list;
> +	size = platform_certificate_list_size;
> +
> +	keyring = integrity_keyring_from_id(INTEGRITY_KEYRING_PLATFORM);
> +	if (IS_ERR(keyring))
> +		return PTR_ERR(keyring);
> +
> +	rc = load_certificate_list(p, size, keyring);
> +	if (rc)
> +		pr_info("Error adding keys to platform keyring %d\n", rc);
> +
> +	return rc;
> +}
> +late_initcall(load_builtin_platform_cert);
> +
>  /*
>   * Create the trusted keyrings.
>   */


