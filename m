Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4483E163E
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Aug 2021 16:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241823AbhHEOBH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Aug 2021 10:01:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12732 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238069AbhHEOBH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Aug 2021 10:01:07 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 175DZAVU064983;
        Thu, 5 Aug 2021 10:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=wouwzQZTCNlnpx1DBk0AV8sywz7PyVmLvpTAhdYJBxY=;
 b=eZvtyKD7C82YMCP1szP4BSGOtS3u6aONh02QNEaBc8W2rAZ3iRRBZtCEDZEoY9u1tu3B
 UIwVvNjDS2/QXYB3wYL9oBFNKXEA9xTdc0kNUTIahpySOgMmHjbfFDo53fwxm8nIL8cQ
 uE+2iRT1ZhhNehcVshwaX4lSLELzTvdKF6kcOqck+DlF5MyKyvczMrsJhI3mc4nWh2wo
 3i6I2qbQwYjhvrLCeHt0MW3uG/rBtnUlvCLFa/ae0eUUqVNyr3v11MD9dug+ZfjItLcG
 G5OUepNpaxnVsb5wBlTvkJcMyrw1WgAAL5RtPJIDH0+XEjeJBBpylN8AoeF7sU6b6OQ3 XA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a897nn8dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Aug 2021 10:00:31 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 175DnlYK136073;
        Thu, 5 Aug 2021 10:00:30 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a897nn8b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Aug 2021 10:00:30 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 175Dwrtt024086;
        Thu, 5 Aug 2021 14:00:27 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 3a4x58t51y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Aug 2021 14:00:27 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 175DvQvg31588654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Aug 2021 13:57:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45C1FAE05A;
        Thu,  5 Aug 2021 14:00:24 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 349D1AE0A6;
        Thu,  5 Aug 2021 14:00:19 +0000 (GMT)
Received: from sig-9-65-205-127.ibm.com (unknown [9.65.205.127])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Aug 2021 14:00:18 +0000 (GMT)
Message-ID: <456fea5f63f14a342791388e6e8d34605ef13eb5.camel@linux.ibm.com>
Subject: Re: [PATCH RFC v2 02/12] KEYS: CA link restriction
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jarkko@kernel.org, jmorris@namei.org,
        serge@hallyn.com
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, scott.branden@broadcom.com,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        glin@suse.com, konrad.wilk@oracle.com
Date:   Thu, 05 Aug 2021 10:00:18 -0400
In-Reply-To: <20210726171319.3133879-3-eric.snowberg@oracle.com>
References: <20210726171319.3133879-1-eric.snowberg@oracle.com>
         <20210726171319.3133879-3-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: H3nh4gAsq6mDfpVhyljeEIsVgs87D9JY
X-Proofpoint-GUID: sHb-rYluSo52uSCH5PQ8YjaifqQNNbBa
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-05_04:2021-08-05,2021-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108050082
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-07-26 at 13:13 -0400, Eric Snowberg wrote:
> Add a new link restriction.  Restrict the addition of keys in a keyring
> based on the key to be added being a CA (self-signed) or by being
> vouched for by a key in either the built-in or the secondary trusted
> keyrings.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

As discussed, please remove "or by being vouched for by a key in
either the built-in or the secondary trusted keyrings."

If these keys were to be loaded onto a keyring other than the platform
keyring, they should be loaded onto the secondary keyring.  The
secondary restriction currently allows certificates signed by keys on
either the builtin or the secondary keyring, to be loaded onto the
secondary keyring.   A new restriction would also allow certificates
signed by keys on the ".mok" keyring.

> +/**
> + * restrict_link_by_ca - Restrict additions to a ring of public keys
> + * based on it being a CA
> + * @dest_keyring: Keyring being linked to.
> + * @type: The type of key being added.
> + * @payload: The payload of the new key.
> + * @trusted: A key or ring of keys that can be used to vouch for the new cert.
> + *
> + * Check if the new certificate is a CA or if they key can be vouched for
> + * by keys already linked in the destination keyring or the trusted
> + * keyring.  If one of those is the signing key or it is self signed, then
> + * mark the new certificate as being ok to link.
> + *
> + * Returns 0 if the new certificate was accepted, -ENOKEY if we could not find
> + * a matching parent certificate in the trusted list.  -ENOPKG if the signature
> + * uses unsupported crypto, or some other error if there is a matching
> + * certificate  but the signature check cannot be performed.
> + */

Please update the function description as discussed, removing "or if they
key can be vouched for by keys already linked in the destination
keyring or the trusted keyring."

The kernel doc "Brief description of function" should not wrap.  The
variable definition shouldn't be suffixed with a period.  Please refer
to Documentation/doc-guide/kernel-doc.rst.

> +int restrict_link_by_ca(struct key *dest_keyring,

The UEFI db CA keys should only be loaded on boot.  Should this be
annotated as __init?

> +			const struct key_type *type,
> +			const union key_payload *payload,
> +			struct key *trust_keyring)
> +{
> +	const struct public_key_signature *sig;
> +	const struct public_key *pkey;
> +	struct key *key;
> +	int ret;
> +
> +	if (type != &key_type_asymmetric)
> +		return -EOPNOTSUPP;
> +
> +	sig = payload->data[asym_auth];
> +	if (!sig)
> +		return -ENOPKG;
> +
> +	if (!sig->auth_ids[0] && !sig->auth_ids[1])
> +		return -ENOKEY;
> +
> +	pkey = payload->data[asym_crypto];
> +	if (!pkey)
> +		return -ENOPKG;
> +
> +	ret = public_key_verify_signature(pkey, sig);
> +	if (!ret)
> +		return 0;
> +
> +	if (!trust_keyring)
> +		return -ENOKEY;
> +
> +	key = find_asymmetric_key(trust_keyring,
> +				  sig->auth_ids[0], sig->auth_ids[1],
> +				  false);
> +	if (IS_ERR(key))
> +		return -ENOKEY;
> +
> +	ret = verify_signature(key, sig);
> +	key_put(key);
> +	return ret;
> +}
> +
>  static bool match_either_id(const struct asymmetric_key_ids *pair,
>  			    const struct asymmetric_key_id *single)
>  {


> +extern int restrict_link_by_system_trusted_or_ca(
> +	struct key *dest_keyring,
> +	const struct key_type *type,
> +	const union key_payload *payload,
> +	struct key *restrict_key);

After the discussed change, this shouldn't be needed.

thanks,

Mimi

> +
>  #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
>  extern int restrict_link_by_builtin_and_secondary_trusted(
>  	struct key *keyring,


