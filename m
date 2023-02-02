Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543CC688854
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Feb 2023 21:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjBBUkk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Feb 2023 15:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjBBUkb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Feb 2023 15:40:31 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F324721D4;
        Thu,  2 Feb 2023 12:40:27 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312JgFQD004167;
        Thu, 2 Feb 2023 20:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=/P40I9lhRL1NhO22/7a9lgTefIhVLNT4SIP3fC6llSQ=;
 b=BRDrwe9xMgHtpl4Hi8Ut7LGuy6anlRCjxLF7MK7vKvkqWP1dBf5xQgPkj4xxPPp1Jm8m
 I8dPcN9k0scFFixB/IqxH5E4uvoZ+JIuXmq2lQ8gTf/IcST75G442j93MZqzw66gA5YA
 FYiANajU80muOocsbYloojgL9obt/aBqCNGBqRe37/9NIX0rS6B5Ko7lneIriF8fTdK8
 dZJaT9x9w2CnamU/fvvRACmER3fXjQZEeF7CmCYBmjkPmIXCIAzQWRU3XZSlPX3Rqg9z
 QlNSbTKflDySRVVABeSO83S4fp5bwQypYaBfEanjSXDf83qB3E8AZLRXsk40cjgR10ka 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngka5hnex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 20:40:10 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 312KeAtk003930;
        Thu, 2 Feb 2023 20:40:10 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngka5hneh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 20:40:10 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 312IKl1m008923;
        Thu, 2 Feb 2023 20:40:09 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3ncvw34pv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 20:40:09 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 312Ke7aK41288180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Feb 2023 20:40:07 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77AE05804C;
        Thu,  2 Feb 2023 20:40:07 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEC035805D;
        Thu,  2 Feb 2023 20:40:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.72.62])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  2 Feb 2023 20:40:06 +0000 (GMT)
Message-ID: <805425ab66a004b110cf0c33423ba5a4247c5cb4.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v4] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanb@linux.ibm.com,
        viro@zeniv.linux.org.uk, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 02 Feb 2023 15:40:06 -0500
In-Reply-To: <ae83bc62a798180281b2bcf6a469e97586d2af7c.camel@huaweicloud.com>
References: <20230202135131.2445816-1-roberto.sassu@huaweicloud.com>
         <fbac5d34fee2c3d4bbf036c06252fd0671577558.camel@linux.ibm.com>
         <ae83bc62a798180281b2bcf6a469e97586d2af7c.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ndYC0bBmwyJVnxjvb6-3po3T6LCG4YF-
X-Proofpoint-ORIG-GUID: Al60h4IGXIt64XGJQJeWvGoOtOpF0MCo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_14,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020182
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-02-02 at 17:23 +0100, Roberto Sassu wrote:
> > > +   if (ptr == MAP_FAILED) {
> > > +           ret = ERR_SETUP;
> > > +           if (argv[2] && !strcmp(argv[2], "exec_on_writable") &&
> > > +               errno == EACCES)
> > > +                   ret = ERR_TEST;
> > > +
> > 
> > FYI, on an older distro kernel, the mmap fails and results in following
> > without any explanation.
> > 
> > Test: check_mmap (hook="MMAP_CHECK", test_mmap arg: "exec")
> > Unexpected exit status 1 from test_mmap
> > 
> > With some additional debugging, I'm seeing:
> > Failed mmap() /tmp/tmp.4gD2UjSvC4/tmp.PlzUEm09hO, err: -13 (Permission
> > denied)b
> 
> Uhm, ok. Which kernel is failing?

I'm able to reproduce the error on a next-integrity or next-integrity-
testing kernel, by running the tests multiple times.  The error doesn't
occur the first time running the test, but subsequent times.

Mimi

