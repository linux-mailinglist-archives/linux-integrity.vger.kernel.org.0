Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E20A680EDE
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Jan 2023 14:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbjA3N2e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Jan 2023 08:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbjA3N2c (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Jan 2023 08:28:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADB236FC7
        for <linux-integrity@vger.kernel.org>; Mon, 30 Jan 2023 05:28:25 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UC9b3c016189;
        Mon, 30 Jan 2023 13:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=oM4A+kDv3z7OQL0Ot/GSkC2E3r6xcnhPSxnvfpwG9C4=;
 b=Chh+EyNd9B81ufsnikP0YL+7dXdRWonRUuDj81qXCE6g0WmEurA7OfRXwdRTSIxhlj8Z
 7YITykbW3YuhQ0CTZn+QRevfeZ1CQR7yOVipYX3OfEu92nIadA4hUG55BrFqhNNdbvtU
 voM9oExWEfifZluG0Ii368ISfvrMom03313A0q1UMvN6BeMsE63L8l8ILpa4QPxKbb26
 EU4Z1z57pJIQfvBRPVW/dfwwdq8cO9d6MAGJ9vVokFnjiBWBWvcPJZvLrr6+5+LJhFHj
 3+skHm26wJm7fpAzTAzIohyM5JwqjpmVjG/m/7hBS6ULEXp/oowgdtYiyvSH8VSwrDd+ cw== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nebxev7jp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 13:28:06 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30UCDUpC026809;
        Mon, 30 Jan 2023 13:28:05 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3ncvtmtupb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 13:28:05 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30UDS4Yf11665996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 13:28:04 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8519658053;
        Mon, 30 Jan 2023 13:28:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E29ED58043;
        Mon, 30 Jan 2023 13:28:03 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.4.127])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 30 Jan 2023 13:28:03 +0000 (GMT)
Message-ID: <420799029373c9e0feae4eb21ca27b7253494591.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Petr Vorel <pvorel@suse.cz>
Date:   Mon, 30 Jan 2023 08:28:03 -0500
In-Reply-To: <36d25da9b9b6aa004311e083a67bc44f3edcf05c.camel@huaweicloud.com>
References: <20230126163812.1870942-1-roberto.sassu@huaweicloud.com>
         <20230126163812.1870942-3-roberto.sassu@huaweicloud.com>
         <5a2b46ef-71de-03f5-3d4d-ef6834a33971@linux.ibm.com>
         <36d25da9b9b6aa004311e083a67bc44f3edcf05c.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ehonejg0driLhykEq_atPv0Au0rgHvum
X-Proofpoint-ORIG-GUID: Ehonejg0driLhykEq_atPv0Au0rgHvum
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_12,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Trimmed Cc list, since this is an ima-evm-utils discussion.  Adding
Petr.]

On Fri, 2023-01-27 at 08:57 +0100, Roberto Sassu wrote:
> On Thu, 2023-01-26 at 17:25 -0500, Stefan Berger wrote:

> > How do you tell the user that the patches need to be applied for the test to
> > succeed and not worry about it when the patches are not applied?
> 
> Uhm, I agree. I should at least write a comment as for EVM portable
> signatures, and maybe display a message in the test logs.

This is a generic problem that needs to be addressed.  FYI, LTP
addressed it by introducing "struct test_tag" in commit ca2c76990
("lib: Add support for test tags").

thanks,

Mimi

