Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471594F9861
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Apr 2022 16:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbiDHOnb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 Apr 2022 10:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbiDHOna (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Apr 2022 10:43:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E317DEE4F9;
        Fri,  8 Apr 2022 07:41:26 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 238E7t4m021971;
        Fri, 8 Apr 2022 14:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=6XyRvsY5Mk4uadCfC7MVBc5XR0tKINg7kvv9OHqmGKw=;
 b=iF+LU1UKhnG8Xr6+kVuBdgr6/GJJ/w7gCUX7PWWgOIl2Uguz9018a7mrnpPuEjkJjsrM
 J01Rox6ytMsW9I2wLhmW+2Dngeo3P8wG/QrwEqFYBK3dnE/m3rIXamDi+JSYnDczdpwE
 O7QkqVN+kdhieGw9BPXvONt9v8wgzoe367FJ+ymq4Xmcf/1VgmoGBjPLFJTXQa2Enegh
 0FMzqEhVo75wolnjXUYQa0/moPw2hBf4nF5zkhVFfUTABLkf0FUinxibCLdXBhVbyLGT
 Gc/C+vvR5ksQ6tBYvUYVCR7/tD/Fs1WTIuQy/evKc0Phd1ShuAWPd1wgj5NeksETQP7w 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3faeqqaaqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 14:41:04 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 238EbqGD009481;
        Fri, 8 Apr 2022 14:41:03 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3faeqqaapv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 14:41:03 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 238Eb1hi000773;
        Fri, 8 Apr 2022 14:41:01 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3f6e4940gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 14:41:01 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 238Eex3j28573980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Apr 2022 14:40:59 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5024AE04D;
        Fri,  8 Apr 2022 14:40:58 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4F06AE045;
        Fri,  8 Apr 2022 14:40:56 +0000 (GMT)
Received: from sig-9-65-90-167.ibm.com (unknown [9.65.90.167])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Apr 2022 14:40:56 +0000 (GMT)
Message-ID: <4fbef0889d6f286c7fcd317db099b4857e1b2fa3.camel@linux.ibm.com>
Subject: Re: [PATCH 4/7] KEYS: Introduce a builtin root of trust key flag
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, dhowells@redhat.com,
        dwmw2@infradead.org, jarkko@kernel.org,
        linux-integrity@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        roberto.sassu@huawei.com, nramas@linux.microsoft.com,
        pvorel@suse.cz, tiwai@suse.de, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Fri, 08 Apr 2022 10:40:56 -0400
In-Reply-To: <20220406015337.4000739-5-eric.snowberg@oracle.com>
References: <20220406015337.4000739-1-eric.snowberg@oracle.com>
         <20220406015337.4000739-5-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kjFgXY9MPZJxmZcrovWlAGcFML1ksws9
X-Proofpoint-ORIG-GUID: t789_J2LfMLqzK8ZtrgPYj85Rb4mnbx_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_05,2022-04-08_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204080071
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-04-05 at 21:53 -0400, Eric Snowberg wrote:
> Some subsystems are interested in knowing if keys within a keyring could
> be used as a foundation of a root of trust.  Introduce a new builtin root
> of trust key flag.

Unfortunately a root of trust is not something that can simply be built
into a certificate.  Roots of trust are normally established based on
HW.  The root of trust for the "builtin_trusted_keys" is established
for systems with secure boot enabled by verifying the signature chain
of trust up to and including the kernel image's signature.  Similarly,
the root of trust for keys on the "secondary_trusted_keys" is based on
all certificates being signed by a key on the "builtin_trusted_keys"
keyring or other keys on the "secondary_trusted_keys" keyring.

Defining a new variable claiming that a root-ca with cert signing usage
on any keyring is a root of trust is just wrong.

> 
> The first type of key to use this is X.509.  When a X.509 certificate
> is self signed, has the kernCertSign Key Usage set and contains the
> CA bit set this new flag is set.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

> 
> diff --git a/include/linux/key.h b/include/linux/key.h
> index 7febc4881363..97f6a1f86a27 100644
> --- a/include/linux/key.h
> +++ b/include/linux/key.h
> @@ -230,6 +230,7 @@ struct key {
>  #define KEY_FLAG_ROOT_CAN_INVAL	7	/* set if key can be invalidated by root without permission */
>  #define KEY_FLAG_KEEP		8	/* set if key should not be removed */
>  #define KEY_FLAG_UID_KEYRING	9	/* set if key is a user or user session keyring */
> +#define KEY_FLAG_BUILTIN_ROT	10	/* set if key is a builtin Root of Trust key */
>  
>  	/* the key type and key description string
>  	 * - the desc is used to match a key against search criteria
> @@ -290,6 +291,7 @@ extern struct key *key_alloc(struct key_type *type,
>  #define KEY_ALLOC_BYPASS_RESTRICTION	0x0008	/* Override the check on restricted keyrings */
>  #define KEY_ALLOC_UID_KEYRING		0x0010	/* allocating a user or user session keyring */
>  #define KEY_ALLOC_SET_KEEP		0x0020	/* Set the KEEP flag on the key/keyring */
> +#define KEY_ALLOC_BUILT_IN_ROT		0x0040  /* Add builtin root of trust key */

Since the concept of root of trust is not generic, but limited to
specific keyrings, the root CA certificate signing keys on the
"machine" keyring need to be identified.  Similar to the
KEY_ALLOC_BUILT_IN/KEY_FLAG_BUILTIN, new flags
KEY_ALLOC_MACHINE/KEY_FLAG_MACHINE should be defined instead.

thanks,

Mimi

