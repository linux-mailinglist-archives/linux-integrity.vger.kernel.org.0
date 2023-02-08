Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05D268F9DD
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Feb 2023 22:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjBHVsy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Feb 2023 16:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjBHVsx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Feb 2023 16:48:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720681E5D6;
        Wed,  8 Feb 2023 13:48:52 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318LHv8P014603;
        Wed, 8 Feb 2023 21:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=P3F//S2WmagtKbNpt0cp03T9qmqZyNd1ebxOd2KomBw=;
 b=W32b0R3ArQHxnwSaULPgt8vS7kR1EV9oaIHNg7acXkuDjkaUoEVwOvisay7wcft7B2jh
 CX7W1c+8KqBDY7ku/JXQrCAbPiMiaXlbd7NUMcJa8aoXFl1DrSy3Dt2sudJkUYqiWqfI
 tOXRnhQN70+eey7q2xTc+5a20D4/uaKsjJRrdWsHdLI7wviyPag8oA9ixRJp4mWRcwkR
 3qjyc6lhpNC+DivP2u642wyfd1ExHTqI1GUj/azkR/Xc1NYLeDjA0wrpVaB3If9PUSl0
 gEQPCwSh1Lbyz64wLz+ktve/ln0A7tqEs7O6XS08S6oBnrgOrRnRzSpaZiQBV7HpMezE rA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmkhb8r32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 21:48:35 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 318LWioR009974;
        Wed, 8 Feb 2023 21:48:35 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmkhb8r2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 21:48:35 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 318JfoIr027767;
        Wed, 8 Feb 2023 21:48:33 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3nhf07ybvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 21:48:33 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 318LmW8F40239706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Feb 2023 21:48:32 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F7E558054;
        Wed,  8 Feb 2023 21:48:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DD6E5805A;
        Wed,  8 Feb 2023 21:48:29 +0000 (GMT)
Received: from sig-9-65-211-196.ibm.com (unknown [9.65.211.196])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Feb 2023 21:48:29 +0000 (GMT)
Message-ID: <ea1974af48bfd0e6dfbaa63e59d38a46847c74e6.camel@linux.ibm.com>
Subject: Re: [PATCH v4 2/6] KEYS: Add missing function documentation
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, jarkko@kernel.org,
        dhowells@redhat.com, dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, tadeusz.struk@intel.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        erpalmer@linux.vnet.ibm.com, coxu@redhat.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Wed, 08 Feb 2023 16:48:29 -0500
In-Reply-To: <20230207025958.974056-3-eric.snowberg@oracle.com>
References: <20230207025958.974056-1-eric.snowberg@oracle.com>
         <20230207025958.974056-3-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K9xz-VKM3Avtnpy35KzXf2Vz1E7AgjyY
X-Proofpoint-ORIG-GUID: X67xvf_kL7wCZGtWmONxP9LVe3xONopZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_09,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080183
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-02-06 at 21:59 -0500, Eric Snowberg wrote:
> Compiling with 'W=1' results in warnings that 'Function parameter or member
> not described'
> 
> Add the missing parameters for
> restrict_link_by_builtin_and_secondary_trusted and
> restrict_link_to_builtin_trusted.
> 
> Use /* instead of /** for get_builtin_and_secondary_restriction, since
> it is a static function.
> 
> Fix wrong function name restrict_link_to_builtin_trusted.
> 
> Fixes: d3bfe84129f6 ("certs: Add a secondary system keyring that can be added to dynamically")
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  certs/system_keyring.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 5042cc54fa5e..e531b88bc570 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -33,7 +33,11 @@ extern __initconst const unsigned long system_certificate_list_size;
>  extern __initconst const unsigned long module_cert_size;
>  
>  /**
> - * restrict_link_to_builtin_trusted - Restrict keyring addition by built in CA
> + * restrict_link_by_builtin_trusted - Restrict keyring addition by built in CA

While fixing the kernel doc, might as well update "built in" to be
consistent.

> + * @dest_keyring: Keyring being linked to.
> + * @type: The type of key being added.
> + * @payload: The payload of the new key.
> + * @restriction_key: A ring of keys that can be used to vouch for the new cert.
>   *
>   * Restrict the addition of keys into a keyring based on the key-to-be-added
>   * being vouched for by a key in the built in system keyring.
> @@ -50,7 +54,11 @@ int restrict_link_by_builtin_trusted(struct key *dest_keyring,
>  #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
>  /**
>   * restrict_link_by_builtin_and_secondary_trusted - Restrict keyring
> - *   addition by both builtin and secondary keyrings
> + *   addition by both builtin and secondary keyrings.

and here 

> + * @dest_keyring: Keyring being linked to.
> + * @type: The type of key being added.
> + * @payload: The payload of the new key.
> + * @restrict_key: A ring of keys that can be used to vouch for the new cert.
>   *
>   * Restrict the addition of keys into a keyring based on the key-to-be-added
>   * being vouched for by a key in either the built-in or the secondary system

and here

> @@ -75,7 +83,7 @@ int restrict_link_by_builtin_and_secondary_trusted(
>  					  secondary_trusted_keys);
>  }
>  
> -/**
> +/*
>   * Allocate a struct key_restriction for the "builtin and secondary trust"
>   * keyring. Only for use in system_trusted_keyring_init().
>   */

Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>

