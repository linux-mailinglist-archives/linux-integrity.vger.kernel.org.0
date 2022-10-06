Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EFB5F66F1
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Oct 2022 14:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiJFMy7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Oct 2022 08:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiJFMyc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Oct 2022 08:54:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C7D63DE;
        Thu,  6 Oct 2022 05:53:59 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296CAnM1013905;
        Thu, 6 Oct 2022 12:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=CYgo/2rN5z6rrw2ZjFqAtZ+Y7uhvzyRCXa/pxROV9zk=;
 b=KyLpF3nO6PH+ZUmSb8hNmUNkt0+AaAT/G8aadOACy79mYO12ugTnRf+vcqa6P1WWIkkw
 3U7WEcDUdCa4ZrqiHUU6Ryr0hF0yUZ6ZPyILzt6olnkbH5G/qC+iCr3HQTvlumU5sQah
 UD96II9w0xB5VhPTSOg/CRwiBCO+KsXsM9NoVnFlkuEK0L/WjOCFNYHmTC53Jn/D/BfW
 XbFJm6Ox+yCZuWkJijzYy3wzY13MzP9HqtgG6k2+xlImSavuEIoDmNl4mp6EwFnVE0VS
 K2rYHWDpU48J0Or/KQA7/2VxqUjlhexc891nTiU8Qc8S5yoiyZNj2pSNgp2iGRFW4/ao Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k1wptk3m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 12:52:29 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 296CBYvW020519;
        Thu, 6 Oct 2022 12:52:28 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k1wptk3kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 12:52:28 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 296CpnJJ018175;
        Thu, 6 Oct 2022 12:52:27 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03dal.us.ibm.com with ESMTP id 3jxd6aaskb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 12:52:27 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 296CqQmF21430934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Oct 2022 12:52:26 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B4A07805E;
        Thu,  6 Oct 2022 13:22:45 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B0F97805C;
        Thu,  6 Oct 2022 13:22:40 +0000 (GMT)
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [9.163.75.48])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  6 Oct 2022 13:22:40 +0000 (GMT)
Message-ID: <0c6bbab890df1eaccbc6882a2ca86e483e70bd93.camel@linux.ibm.com>
Subject: Re: [PATCH v0 6/8] KEYS: trusted: caam based black key
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     list.lkml.keyrings@me.benboeckel.net,
        Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     jarkko@kernel.org, a.fatoum@pengutronix.de, gilad@benyossef.com,
        Jason@zx2c4.com, zohar@linux.ibm.com, dhowells@redhat.com,
        sumit.garg@linaro.org, david@sigma-star.at, michael@walle.cc,
        john.ernberg@actia.se, jmorris@namei.org, serge@hallyn.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        j.luebbe@pengutronix.de, ebiggers@kernel.org, richard@nod.at,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, sahil.malhotra@nxp.com,
        kshitiz.varshney@nxp.com, horia.geanta@nxp.com, V.Sethi@nxp.com
Date:   Thu, 06 Oct 2022 08:52:20 -0400
In-Reply-To: <Yz7NOB1vePLE4yoB@megas.dev.benboeckel.internal>
References: <20221006130837.17587-1-pankaj.gupta@nxp.com>
         <20221006130837.17587-7-pankaj.gupta@nxp.com>
         <Yz7NOB1vePLE4yoB@megas.dev.benboeckel.internal>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w0L2TfLfJepXNX9F2oQfOhqz5iBZvgOm
X-Proofpoint-ORIG-GUID: DNOgdM8HEVDeZSOXkp86VoWgZK-DQp2J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_01,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxlogscore=867 clxscore=1011 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060072
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-10-06 at 08:42 -0400, Ben Boeckel wrote:
> On Thu, Oct 06, 2022 at 18:38:35 +0530, Pankaj Gupta wrote:
> > - CAAM supports two types of black keys:
> >   -- Plain key encrypted with ECB
> >   -- Plain key encrypted with CCM
> 
> What is a "black key"? Is this described in the documentation or
> local comments at all? (I know I'm unfamiliar with CAAM, but maybe
> this should be mentioned somewhere?).
> 
> >   Note: Due to robustness, default encytption used for black key is
> > CCM.
>                                      ^^^^^^^^^^ encryption
> 
> What "robustness"? Surely there's some more technical details
> involved here?

The crypto advice for the past decade or more has been never use ECB
it's insecure, so anything could be regarded as robust compared to it
... however that does beg the question of why ECB is even offered in a
modern system?  Surely it's nothing more than a user trap (choose this
secure option only if you don't want security).

James


