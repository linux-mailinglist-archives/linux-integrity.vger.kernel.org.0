Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C5A6816F9
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Jan 2023 17:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbjA3Qy3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Jan 2023 11:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjA3Qy3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Jan 2023 11:54:29 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3090B3D92D
        for <linux-integrity@vger.kernel.org>; Mon, 30 Jan 2023 08:54:28 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UFqVsr008213;
        Mon, 30 Jan 2023 16:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ufC/4r3d8VOgf5Kicgh3ChiPgFuyiQGfLL1uwdEkKJc=;
 b=KPRySj3bJVWFl3WCCc8gH5riZMSkkVElmE0xuTDsmKdbaJzPVT6SjVWFS5yCaRrRjZ1J
 5fjqFr3SsBLIbJ3kfmsnyNF/yQIS6vrIgKiroV+HwksjD6XiToS/iotIOjeWkTnlaV1W
 aT1vOxYK3vJha25WdDJLOWLEDO1gyM5U9b3CtqJpe9yAdoQ/cQUtYJKQTw+3+99gc9bE
 tSVTnWTsX7xz7pMlKrcA7H98U77Xw8Us44bT3FrZR5jGU00Igk8gJLnQgUt9kAOfGLeV
 4BK5y4mmTAxKneQa5iqrMUaIuS8E/rtrh2qfgfiXxQwpkJay5mD/STlkYcnczPFCuRah PA== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3negwyhk6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 16:54:08 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30UFrTFr028721;
        Mon, 30 Jan 2023 16:54:08 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3ncvuybpen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 16:54:08 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30UGs7li6554228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 16:54:07 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1074B58054;
        Mon, 30 Jan 2023 16:54:07 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73B9158058;
        Mon, 30 Jan 2023 16:54:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.103])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 30 Jan 2023 16:54:06 +0000 (GMT)
Message-ID: <f8680ef9a0522cbe07fe02eb31a40c4a19a5e068.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Petr Vorel <pvorel@suse.cz>
Date:   Mon, 30 Jan 2023 11:54:06 -0500
In-Reply-To: <7779927be4c5506172c5a64e3cea37ad9c285356.camel@huaweicloud.com>
References: <20230126163812.1870942-1-roberto.sassu@huaweicloud.com>
         <20230126163812.1870942-3-roberto.sassu@huaweicloud.com>
         <5a2b46ef-71de-03f5-3d4d-ef6834a33971@linux.ibm.com>
         <36d25da9b9b6aa004311e083a67bc44f3edcf05c.camel@huaweicloud.com>
         <420799029373c9e0feae4eb21ca27b7253494591.camel@linux.ibm.com>
         <c5b46ac1e81b60aefebcf81dabe9e5a911a259a4.camel@huaweicloud.com>
         <7779927be4c5506172c5a64e3cea37ad9c285356.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HEmBoJSv54quZB0_Bi3Q2Ut-Wq_CDrlZ
X-Proofpoint-ORIG-GUID: HEmBoJSv54quZB0_Bi3Q2Ut-Wq_CDrlZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_15,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301300160
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-01-30 at 17:07 +0100, Roberto Sassu wrote:
> On Mon, 2023-01-30 at 15:02 +0100, Roberto Sassu wrote:
> > On Mon, 2023-01-30 at 08:28 -0500, Mimi Zohar wrote:
> > > [Trimmed Cc list, since this is an ima-evm-utils discussion.  Adding
> > > Petr.]
> > > 
> > > On Fri, 2023-01-27 at 08:57 +0100, Roberto Sassu wrote:
> > > > On Thu, 2023-01-26 at 17:25 -0500, Stefan Berger wrote:
> > > > > How do you tell the user that the patches need to be applied for the test to
> > > > > succeed and not worry about it when the patches are not applied?
> > > > 
> > > > Uhm, I agree. I should at least write a comment as for EVM portable
> > > > signatures, and maybe display a message in the test logs.
> > > 
> > > This is a generic problem that needs to be addressed.  FYI, LTP
> > > addressed it by introducing "struct test_tag" in commit ca2c76990
> > > ("lib: Add support for test tags").
> > 
> > One idea could be to list all the patches the group of tests is going
> > to check, and add an argument to expect_pass and expect_fail to specify
> > the indexes of patches required for the test. We print the required
> > patches in an error message.
> 
> Ok, here is an example for this patch set. I added the following
> changes to the mmap_check.test script:
> 
> PATCHES=(
> 'ima: Align ima_file_mmap() parameters with mmap_file LSM hook'
> 'ima: Introduce MMAP_CHECK_REQPROT hook'
> )

This works for bug fixes, where the patch list is relatively small. 
I'm not sure this will work so well for new kernel features.
-- 
Mimi


