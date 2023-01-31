Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B505568340D
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Jan 2023 18:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjAaRjl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Jan 2023 12:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjAaRjk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Jan 2023 12:39:40 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EEB93D3
        for <linux-integrity@vger.kernel.org>; Tue, 31 Jan 2023 09:39:38 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VG07Ut010814
        for <linux-integrity@vger.kernel.org>; Tue, 31 Jan 2023 17:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=iiLjKsxHf1DVjohici0WEbiYtJtpyJqhjZPH3LyIxXI=;
 b=UmAVUW8HAGjhAAQyp9bV06Y3srtOEbMY0I4J4V4Au+WOAVR18IFvFnqFKj2UNMh1qRX9
 nqLj33MNM3HmkvU4LXVIVlkmEI9ca8A9mR0Td+FDCyjdV0yMiVunJ77C3axGRudS8GfH
 JUaL0QZSD3IMz/vHvd+65GNTtjNVk8GtDE2xpTF2VHLFc4yzn9NImiQ5TbaaRRSvJi8o
 GPWWlNmn2F5cdAMuQCOiXFV17JMy6VxAsPYa+EnvZwyfiLPfF7eC2mVj4STTLaiEKlea
 bWRvYLeTruklKcmSHElGlckoDdfVX+b14GueJ7FilhZLDQbKoPRiNF+a73FYUbNUgbmX Og== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf5q6kfuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 31 Jan 2023 17:39:38 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30VGAheL008456
        for <linux-integrity@vger.kernel.org>; Tue, 31 Jan 2023 17:39:37 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3ncvw2nh61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 31 Jan 2023 17:39:37 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30VHdag534341320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Tue, 31 Jan 2023 17:39:36 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2039758052
        for <linux-integrity@vger.kernel.org>; Tue, 31 Jan 2023 17:39:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9DB85804C
        for <linux-integrity@vger.kernel.org>; Tue, 31 Jan 2023 17:39:35 +0000 (GMT)
Received: from sig-9-77-155-214.ibm.com (unknown [9.77.155.214])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP
        for <linux-integrity@vger.kernel.org>; Tue, 31 Jan 2023 17:39:35 +0000 (GMT)
Message-ID: <312e87f7d404d14dc28f3fa7838c2df3e5cfbf12.camel@linux.ibm.com>
Subject: Re: [PATCH] Fix reading the TPM 2.0 PCRs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Date:   Tue, 31 Jan 2023 12:39:35 -0500
In-Reply-To: <20230131173344.8147-1-zohar@linux.ibm.com>
References: <20230131173344.8147-1-zohar@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SP6C-VI0nnj2YYSMyMn30OQeMaP49tCI
X-Proofpoint-GUID: SP6C-VI0nnj2YYSMyMn30OQeMaP49tCI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 clxscore=1015 spamscore=0 mlxlogscore=486 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310155
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-01-31 at 12:33 -0500, Mimi Zohar wrote:
> Prior to the support for reading the TPM 2.0 PCRs via the sysfs
> interface, based on environment variables the userspace application read
> either the physical or software TPM's PCRs.
> 
> With the support for reading the exported TPM 2.0 PCRs via the sysfs
> interface, the physical TPM's PCRs are always read.  Define a new evmctl
> option named '--hwtpm' to limit reading the TPM 2.0 PCRs via the sysfs
> interface.
> 
> Fixes: a141bd594263 ("add support for reading per bank TPM 2.0 PCRs via sysfs")
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Sorry for the confusion.  This patch is for ima-evm-utils.  Resent with
the proper subject line.

-- 
thanks,

Mimi



