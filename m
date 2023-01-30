Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D261681655
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Jan 2023 17:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbjA3Q1S (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Jan 2023 11:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbjA3Q1R (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Jan 2023 11:27:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92113B3D1
        for <linux-integrity@vger.kernel.org>; Mon, 30 Jan 2023 08:27:14 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UGBmL3025153;
        Mon, 30 Jan 2023 16:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=f6sgmkqPqQ0FkOtHmMAEt4gUrI9vfPbxUJJi3CPWuDw=;
 b=BnjhD6dHbjexEDq1mNDuGztQgcyJAah8XinPx6zSmpb0Eb5WfrNTtva0aIqt9OMiwgWF
 HfBiN52Jv5m6RCwEsohfv29b6OkjPNTJ8izOW/A6R6mw4zKUgFbznmFgO+EtX2MM+axp
 mc0dP5NCmoTauekNvFm5fK60BH5BrCmixL9zQWQ8fuqXvl+YHo7AqUvHOYxSxlu6K+tL
 Kal/rvSnVdAF68GTROnlSegc+2/x65kSTjFVsnPZZFgGeqew/EWEr2Jwldgv6GN2pTS1
 9HRogHbHGxuU4A6jJbAyuQlAfn13li4Q8TZq6LOzKYXkfD7pW8rWCu8UGOFR5Lzqn19n UA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nefvtu21r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 16:26:52 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30UFRn29019250;
        Mon, 30 Jan 2023 16:26:51 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3ncvuqedbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 16:26:51 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30UGQo738782508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 16:26:50 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B9BF58056;
        Mon, 30 Jan 2023 16:26:50 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E498258052;
        Mon, 30 Jan 2023 16:26:49 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.103])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 30 Jan 2023 16:26:49 +0000 (GMT)
Message-ID: <a275b9b5c0b24beda4398358728ca17e33ca9707.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Petr Vorel <pvorel@suse.cz>
Date:   Mon, 30 Jan 2023 11:26:49 -0500
In-Reply-To: <c5b46ac1e81b60aefebcf81dabe9e5a911a259a4.camel@huaweicloud.com>
References: <20230126163812.1870942-1-roberto.sassu@huaweicloud.com>
         <20230126163812.1870942-3-roberto.sassu@huaweicloud.com>
         <5a2b46ef-71de-03f5-3d4d-ef6834a33971@linux.ibm.com>
         <36d25da9b9b6aa004311e083a67bc44f3edcf05c.camel@huaweicloud.com>
         <420799029373c9e0feae4eb21ca27b7253494591.camel@linux.ibm.com>
         <c5b46ac1e81b60aefebcf81dabe9e5a911a259a4.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FSxMop22krK8FBKme1kbywEHSGSnPFBm
X-Proofpoint-ORIG-GUID: FSxMop22krK8FBKme1kbywEHSGSnPFBm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_15,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300151
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-01-30 at 15:02 +0100, Roberto Sassu wrote:
> On Mon, 2023-01-30 at 08:28 -0500, Mimi Zohar wrote:
> > [Trimmed Cc list, since this is an ima-evm-utils discussion.  Adding
> > Petr.]
> > 
> > On Fri, 2023-01-27 at 08:57 +0100, Roberto Sassu wrote:
> > > On Thu, 2023-01-26 at 17:25 -0500, Stefan Berger wrote:
> > > > How do you tell the user that the patches need to be applied for the test to
> > > > succeed and not worry about it when the patches are not applied?
> > > 
> > > Uhm, I agree. I should at least write a comment as for EVM portable
> > > signatures, and maybe display a message in the test logs.
> > 
> > This is a generic problem that needs to be addressed.  FYI, LTP
> > addressed it by introducing "struct test_tag" in commit ca2c76990
> > ("lib: Add support for test tags").
> 
> One idea could be to list all the patches the group of tests is going
> to check, and add an argument to expect_pass and expect_fail to specify
> the indexes of patches required for the test. We print the required
> patches in an error message.

It's not clear to me what is meant by "group of tests".   Is this at
the granularity of the test - portable signatures, fsverity,
boot_aggregate, etc?  Or, is this at a new grouping of tests?

-- 
Mimi

