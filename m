Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7B552A767
	for <lists+linux-integrity@lfdr.de>; Tue, 17 May 2022 17:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350656AbiEQPxm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 May 2022 11:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350650AbiEQPxl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 May 2022 11:53:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60BA227;
        Tue, 17 May 2022 08:53:40 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HFmXiL021978;
        Tue, 17 May 2022 15:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=sJA5HNvoKyXLH7X+0lH0WPS92sWNHhiOLepPwbTZTr0=;
 b=Rw71t49D8PqBOCh7jHat+NZ4UIMN23nIXWrZ/4ykLbBObKnoTIMa4lXUd+vsir1tKhIi
 LgqwcTHVhmnnfcFEHe23JeV8J6XhiSjUMkg73QXzGXcR/5Tf2r6VI825ACmk/ouqoomW
 mD0Eucns4l4qWvWKrLCtUhlDS5ALhoNWaJZq4XeYGhdVjaPlSxKd/tk1+dMcqndtRCjd
 fVcn1N+N4OcxMNUf08F+23mfeKBaasC98wLbDDuOD4t7DQEo246tl+GWcnYhEO/SOD9v
 6CMGvcfn4Tdhp+MkeYyM/DuBeL8jJgzXEAHKfDy55Y6V4WoLuXrTl2NGlV047tfamqR5 eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4ebt8nyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 15:53:04 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24HFn7gO025135;
        Tue, 17 May 2022 15:53:03 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4ebt8nxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 15:53:03 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24HFqWIp032749;
        Tue, 17 May 2022 15:53:01 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3g2428kk1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 15:53:01 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24HFqwcd43254228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 15:52:58 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEC6BA404D;
        Tue, 17 May 2022 15:52:58 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABE4AA4040;
        Tue, 17 May 2022 15:52:55 +0000 (GMT)
Received: from sig-9-65-95-105.ibm.com (unknown [9.65.95.105])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 May 2022 15:52:55 +0000 (GMT)
Message-ID: <1c6a5ce2564c29a06eca255072a379351a5fc026.camel@linux.ibm.com>
Subject: Re: [PATCH v10 2/7] KEYS: trusted: allow use of kernel RNG for key
 material
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     kernel@pengutronix.de, Sumit Garg <sumit.garg@linaro.org>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        David Gstir <david@sigma-star.at>,
        Michael Walle <michael@walle.cc>,
        John Ernberg <john.ernberg@actia.se>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Horia =?UTF-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Tue, 17 May 2022 11:52:55 -0400
In-Reply-To: <20220513145705.2080323-3-a.fatoum@pengutronix.de>
References: <20220513145705.2080323-1-a.fatoum@pengutronix.de>
         <20220513145705.2080323-3-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SE_jucLUMk1vHaVn0CtxN-mL7pixtwk2
X-Proofpoint-GUID: WeggiYsQgcZKsHI4Vh9DhvROgGdOew6I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_03,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=848 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170095
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-05-13 at 16:57 +0200, Ahmad Fatoum wrote:
>  static int __init init_trusted(void)
>  {
> +       int (*get_random)(unsigned char *key, size_t key_len);
>         int i, ret = 0;
>  
>         for (i = 0; i < ARRAY_SIZE(trusted_key_sources); i++) {
> @@ -322,6 +333,28 @@ static int __init init_trusted(void)
>                             strlen(trusted_key_sources[i].name)))
>                         continue;
>  
> +               /*
> +                * We always support trusted.rng="kernel" and "default" as
> +                * well as trusted.rng=$trusted.source if the trust source
> +                * defines its own get_random callback.
> +                */
 
While TEE trusted keys support was upstreamed, there was a lot of
discussion about using kernel RNG.  One of the concerns was lack of or
insuffiencent entropy during early boot on embedded devices.  This
concern needs to be clearly documented in both Documentation/admin-
guide/kernel-parameters.txt and Documentation/security/keys/trusted-
encrypted.rst.

thanks,

Mimi

> +               get_random = trusted_key_sources[i].ops->get_random;
> +               if (trusted_rng && strcmp(trusted_rng, "default")) {
> +                       if (!strcmp(trusted_rng, "kernel")) {
> +                               get_random = kernel_get_random;
> +                       } else if (strcmp(trusted_rng, trusted_key_sources[i].name) ||
> +                                  !get_random) {
> +                               pr_warn("Unsupported RNG. Supported: kernel");
> +                               if (get_random)
> +                                       pr_cont(", %s", trusted_key_sources[i].name);
> +                               pr_cont(", default\n");
> +                               return -EINVAL;
> +                       }
> +               }
> +
> +               if (!get_random)
> +                       get_random = kernel_get_random;
> +
>                 static_call_update(trusted_key_init,
>                                    trusted_key_sources[i].ops->init);

