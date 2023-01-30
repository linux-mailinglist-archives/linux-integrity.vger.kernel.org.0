Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5DC681717
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Jan 2023 18:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbjA3RBY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Jan 2023 12:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236545AbjA3RBX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Jan 2023 12:01:23 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0183F2B2
        for <linux-integrity@vger.kernel.org>; Mon, 30 Jan 2023 09:01:22 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UGaOXM020250;
        Mon, 30 Jan 2023 17:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=sqE1CW5HIBxnu96K/g1Oi1ZcR2K5nlRCGbGw6brXAQU=;
 b=qbPj6hs1C0xhA9YOI8POy46pFzXfO2PFK8tRCPsrn8QymEeNFRjJGGIRGmtOAkcGcP/k
 QTcdxFOdwon9nK9+zw3JX6jtT0GrC6cEvAT4x0BXmQs6ZiSmxuV3R9VcDMtW2irL/ms2
 YUggjrFOxP67rkpW5gI4hL3wYzfw+0L4xDJapGFWnpzgTLOGa207poW/mhAy/mWhthRB
 uIT6bafL5s/n8mO3U2ZGmFkKcsv5yECcskkCbKJDmAGomv48q6aLBYFr4T+sJAnh0mQa
 /ZPSopVjuoWKR0S+WCJmT+cuBtJ9RQpdjNRttT6wSBN7OZ8RZocmF8hdXiAcW5CCqhHq lg== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3neeg8wypj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 17:00:58 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30UFoNwF028593;
        Mon, 30 Jan 2023 17:00:57 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3ncvuybqdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 17:00:57 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30UH0unZ9699884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 17:00:56 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54C1A58059;
        Mon, 30 Jan 2023 17:00:56 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADFBA58053;
        Mon, 30 Jan 2023 17:00:55 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.103])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 30 Jan 2023 17:00:55 +0000 (GMT)
Message-ID: <3f8704f22433fd368931831ef8d24fd81819f649.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Petr Vorel <pvorel@suse.cz>
Date:   Mon, 30 Jan 2023 12:00:55 -0500
In-Reply-To: <b927056b10cfe491ab4c289a2fc0961d99d96556.camel@huaweicloud.com>
References: <20230126163812.1870942-1-roberto.sassu@huaweicloud.com>
         <20230126163812.1870942-3-roberto.sassu@huaweicloud.com>
         <5a2b46ef-71de-03f5-3d4d-ef6834a33971@linux.ibm.com>
         <36d25da9b9b6aa004311e083a67bc44f3edcf05c.camel@huaweicloud.com>
         <420799029373c9e0feae4eb21ca27b7253494591.camel@linux.ibm.com>
         <c5b46ac1e81b60aefebcf81dabe9e5a911a259a4.camel@huaweicloud.com>
         <a275b9b5c0b24beda4398358728ca17e33ca9707.camel@linux.ibm.com>
         <b927056b10cfe491ab4c289a2fc0961d99d96556.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: plyTFVFo4MLZQH4oWO58xCMH-8hF8tbC
X-Proofpoint-ORIG-GUID: plyTFVFo4MLZQH4oWO58xCMH-8hF8tbC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_16,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300160
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-01-30 at 17:36 +0100, Roberto Sassu wrote:
> On Mon, 2023-01-30 at 11:26 -0500, Mimi Zohar wrote:
> > On Mon, 2023-01-30 at 15:02 +0100, Roberto Sassu wrote:
> > > On Mon, 2023-01-30 at 08:28 -0500, Mimi Zohar wrote:
> > > > [Trimmed Cc list, since this is an ima-evm-utils discussion.  Adding
> > > > Petr.]
> > > > 
> > > > On Fri, 2023-01-27 at 08:57 +0100, Roberto Sassu wrote:
> > > > > On Thu, 2023-01-26 at 17:25 -0500, Stefan Berger wrote:
> > > > > > How do you tell the user that the patches need to be applied for the test to
> > > > > > succeed and not worry about it when the patches are not applied?
> > > > > 
> > > > > Uhm, I agree. I should at least write a comment as for EVM portable
> > > > > signatures, and maybe display a message in the test logs.
> > > > 
> > > > This is a generic problem that needs to be addressed.  FYI, LTP
> > > > addressed it by introducing "struct test_tag" in commit ca2c76990
> > > > ("lib: Add support for test tags").
> > > 
> > > One idea could be to list all the patches the group of tests is going
> > > to check, and add an argument to expect_pass and expect_fail to specify
> > > the indexes of patches required for the test. We print the required
> > > patches in an error message.
> > 
> > It's not clear to me what is meant by "group of tests".   Is this at
> > the granularity of the test - portable signatures, fsverity,
> > boot_aggregate, etc?  Or, is this at a new grouping of tests?
> 
> Sorry, it wasn't clear. I meant all the tests defined in a test script.

No problems.  I hadn't noticed your subsequent example.
> 
> The idea is to associate a list of array indexes with each test
> (argument of expect_pass() or expect_fail()). The indexes refer to the
> PATCHES variable.
> 
> Theoretically, you could also define PATCHES in a common script, called
> by all test scripts, and specify indexes of that array in the test
> scripts.
> 
> I already have a patch, I could send it. Maybe it is more clear.

Yes, I saw what you meant in the subsequent email.

Mimi

