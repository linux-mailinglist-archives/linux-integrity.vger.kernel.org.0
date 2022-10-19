Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B536C605039
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Oct 2022 21:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiJSTOG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Oct 2022 15:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJSTOF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Oct 2022 15:14:05 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ADC1C712E;
        Wed, 19 Oct 2022 12:14:01 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JJCZds022459;
        Wed, 19 Oct 2022 19:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=FdGEPsY/c5x5Vm6zpKCKuQb55uNoKuhuitqyQySnmYQ=;
 b=jDAJRM+0b5wc43wW9L6O3XOIWpLGE37+RJ8YQwUmz727skb23zbITAmUzn5rM8dV1vmc
 W1P2t/f5xHY83KZk8UjZpiMsQPHqen7aZX+YmsavqgZDL2FKVhoXsW5N4xLXhIRRkOx4
 3yEozFzCAtiT1k0TIZoAiqI0kHiVOHmpOtE7czfxkgezauGechtv4gFXw6WLVM5fVYOZ
 bIoQ+yhJn9yYj/+QGStYmt0O38TZr9t2y6GXT1y0fBfijLKjD+Bzc9YTepP6J5FOtluS
 i5VoOyjrTfwitqq6pTkCK6a3/Xt3UMNpYvS9lK6Hz3ZcIEI4Xb03MUeHvEmu1nRLSAWP QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kannsb0cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 19:13:39 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29JIdsXK029467;
        Wed, 19 Oct 2022 19:13:38 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kannsb0c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 19:13:38 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29JJ4rSQ024012;
        Wed, 19 Oct 2022 19:13:37 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 3k7mg9bvjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 19:13:37 +0000
Received: from smtpav06.dal12v.mail.ibm.com ([9.208.128.130])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29JJDYDY20513446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 19:13:35 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30E3858060;
        Wed, 19 Oct 2022 19:13:36 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A19E58061;
        Wed, 19 Oct 2022 19:13:35 +0000 (GMT)
Received: from sig-9-65-252-68.ibm.com (unknown [9.65.252.68])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 19 Oct 2022 19:13:35 +0000 (GMT)
Message-ID: <2ce5e63dc4f15b8015fd7499120ff4256ad1f619.camel@linux.ibm.com>
Subject: Re: [PATCH 1/9] integrity: Prepare for having "ima" and "evm"
 available in "integrity" LSM
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Wed, 19 Oct 2022 15:13:34 -0400
In-Reply-To: <202210191129.BFBF8035@keescook>
References: <20221013222702.never.990-kees@kernel.org>
         <20221013223654.659758-1-keescook@chromium.org>
         <08a8b202-69b4-e154-28f5-337a898acf61@digikod.net>
         <202210141050.A8DF7D10@keescook>
         <0d2b9d34-2eda-8aa6-d596-eb1899645192@digikod.net>
         <202210191129.BFBF8035@keescook>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 87XUx_d22OJZqr9i-tgbHtzejQSVKtyW
X-Proofpoint-GUID: JvaW5FGu2b_1AZFKepq4V-BJhSd3s-OK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_11,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=657
 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210190108
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-10-19 at 11:33 -0700, Kees Cook wrote:
> On Mon, Oct 17, 2022 at 11:26:44AM +0200, Mickaël Salaün wrote:
> > 
> > On 14/10/2022 19:59, Kees Cook wrote:
> > > On Fri, Oct 14, 2022 at 04:40:01PM +0200, Mickaël Salaün wrote:
> > > > This is not backward compatible
> > > 
> > > Why? Nothing will be running LSM hooks until init finishes, at which
> > > point the integrity inode cache will be allocated. And ima and evm don't
> > > start up until lateinit.
> > > 
> > > > , but can easily be fixed thanks to
> > > > DEFINE_LSM().order
> > > 
> > > That forces the LSM to be enabled, which may not be desired?
> > 
> > This is not backward compatible because currently IMA is enabled
> > independently of the "lsm=" cmdline, which means that for all installed
> > systems using IMA and also with a custom "lsm=" cmdline, updating the kernel
> > with this patch will (silently) disable IMA. Using ".order =
> > LSM_ORDER_FIRST," should keep this behavior.
> 
> This isn't true. If "integrity" is removed from the lsm= line today, IMA
> will immediately panic:
> 
> process_measurement():
>   integrity_inode_get():
>         if (!iint_cache)
>                 panic("%s: lsm=integrity required.\n", __func__);
> 
> and before v5.12 (where the panic was added), it would immediately NULL
> deref. (And it took 3 years to even notice.)

Most people were/are still using the "security=" boot command line
option, not "lsm=".  This previously wasn't a problem with "security=",
but became a problem with "lsm=".  I should have been aware of the
change from "security=" to "lsm=", but unfortunately wasn't.  It took
me totally by surprise.   All of sudden "integrity" went from being a
common IMA/EVM resource to an LSM.  The correct solution would have
been to move it a different initcall.  (It's not too late to fix it.)

-- 
thanks,

Mimi

