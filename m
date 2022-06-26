Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B3A55B2C0
	for <lists+linux-integrity@lfdr.de>; Sun, 26 Jun 2022 18:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiFZQNw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 26 Jun 2022 12:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiFZQNv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 26 Jun 2022 12:13:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E803E6466;
        Sun, 26 Jun 2022 09:13:50 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25QFBMY8016249;
        Sun, 26 Jun 2022 16:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=9bOOwg7KyFjJW5FLMZFmjAf3RG25Cs8657ZdDmoMgfM=;
 b=E7n2+R7ISaDMexWYNkaLx+pfmgGes7KY1L4ZW/gAHHanPKGVenCP+pb5t12y7hqMr6cw
 FMukv/cidUlStaGqo8Pp4rH+Jc4SjsdjIF95NoPaxBfyfZiKJSAvLQw5PvApjuudA+FT
 FmxiLLIsdJ5BFbRgza03w+GgN4aVJaNC08KLEWM9T27cgmeEImwQReR2AmnoKlQI3U6G
 vQ1o4fds7ioGLFawQe2R75/q3vvX8jK3CZX/3CesMybgvMd1WWMK4dCmXhXI8qAuXr0O
 LBJCwRMvSayqTWR1Yyw6PHL50S1X/fnfeO1IJc4PsayUL22CH75AovE09KIj35gvvPqr 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gxseph276-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jun 2022 16:13:22 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25QGDMLM011401;
        Sun, 26 Jun 2022 16:13:22 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gxseph26q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jun 2022 16:13:21 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25QG6ot2016412;
        Sun, 26 Jun 2022 16:13:19 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3gwsmj1ra1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jun 2022 16:13:19 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25QGDHdo23331232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jun 2022 16:13:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 146FCA4051;
        Sun, 26 Jun 2022 16:13:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5B87A404D;
        Sun, 26 Jun 2022 16:13:14 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.95.64])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 26 Jun 2022 16:13:14 +0000 (GMT)
Message-ID: <38fd40d03b030f9a60afe4445ddc0daca220e449.camel@linux.ibm.com>
Subject: Re: [PATCH -next] evm: Use IS_ENABLED to initialize .enabled
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     xiujianfeng <xiujianfeng@huawei.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 26 Jun 2022 12:13:13 -0400
In-Reply-To: <YrJ7x3kCTy3ZutZ/@sol.localdomain>
References: <20220606101042.89638-1-xiujianfeng@huawei.com>
         <64511312-df94-c40b-689c-5fc3823e91f5@pengutronix.de>
         <812c4ee9-56f7-900a-df48-f3ca3e15542f@huawei.com>
         <5d0c291bb4a674a6733a18f9eb67cf40193732f4.camel@linux.ibm.com>
         <YrJ7x3kCTy3ZutZ/@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PAS0ahUU4Eu5nM8Lj6csyxE8Ll0pSe7L
X-Proofpoint-ORIG-GUID: CPqnM25LhCrOzG4V4dzu6NrFY7yHn6TU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-26_04,2022-06-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206260067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-06-21 at 19:17 -0700, Eric Biggers wrote:
> On Tue, Jun 21, 2022 at 10:03:39AM -0400, Mimi Zohar wrote:
> > On Tue, 2022-06-21 at 18:58 +0800, xiujianfeng wrote:
> > > Hi, Ahmad
> > > 
> > > 在 2022/6/7 14:06, Ahmad Fatoum 写道:
> > > > On 06.06.22 12:10, Xiu Jianfeng wrote:
> > > >> Use IS_ENABLED(CONFIG_XXX) instead of #ifdef/#endif statements to
> > > >> initialize .enabled, minor simplicity improvement.
> > 
> > The difference between using ifdef's and IS_ENABLED is when the
> > decision is made - build time, run time.   Please update the patch
> > description providing an explanation for needing to make the decision
> > at run time.
> > 
> > thanks,
> 
> IS_ENABLED() is a compile time constant.  So the patch looks fine to me.

Thanks, Eric, for the clarification.

As LSMs are only builtin, why the need for using IS_ENABLED as opposed
to IS_BUILTIN?

#define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))

thanks,

Mimi

