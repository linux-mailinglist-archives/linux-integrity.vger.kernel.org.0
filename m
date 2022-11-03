Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60247618AD0
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 22:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiKCVvD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 17:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKCVvC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 17:51:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310EAC28
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 14:51:02 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3Jk0BL026883
        for <linux-integrity@vger.kernel.org>; Thu, 3 Nov 2022 21:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=/R0HE/hIR0VZM6rU/FzXJ+dymu48rMHXU9gdXtK0I8c=;
 b=Lk+J2qf8y4Q5T51kVfjxSkOXmzCuUppxg70MZW5FBh3fUM4UmzIAqEwvx0d6/3Tf5iEK
 Qtj5ndqi4TH6/mO9O1Q6il2bx4uZvur9zDZO9MHsOMsdAq4vq56Akt0Unpk2QOVOjoUs
 rDNSodtXx7k+wmCFmGe3u5Mv2XF1jYbKJDnqYFGN7BLtd+gGHuywN2hcgdpzgLWwnOEz
 7bvu6o9O0d8meljnpPh5I4KQzXBHSmJAjmLNNAuncY7FixHS0bkc7vNxqQguqkHXpzqq
 7wUFwWNSheEVMo9zr74Wm2aL+qWzeoKfj6MRU6b21w4eh/ehjGaKvRj90o00/prGG319 gw== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmfy059tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 03 Nov 2022 21:51:01 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A3LomUn027400
        for <linux-integrity@vger.kernel.org>; Thu, 3 Nov 2022 21:51:00 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04dal.us.ibm.com with ESMTP id 3kgutan3ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 03 Nov 2022 21:51:00 +0000
Received: from smtpav03.dal12v.mail.ibm.com ([9.208.128.129])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A3Loxkj51249426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Nov 2022 21:50:59 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8D255803F;
        Thu,  3 Nov 2022 21:50:58 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70E3358060;
        Thu,  3 Nov 2022 21:50:58 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.20.100])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  3 Nov 2022 21:50:58 +0000 (GMT)
Message-ID: <33ce3ba2e7bc9967ee44adb9963e49cd7f591707.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v1 0/4] Fix some issues in evmctl
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 03 Nov 2022 17:50:58 -0400
In-Reply-To: <20221102184534.1075049-1-stefanb@linux.ibm.com>
References: <20221102184534.1075049-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lSdURZ7a8gCtoFQW682OT7KljjLHr6x_
X-Proofpoint-ORIG-GUID: lSdURZ7a8gCtoFQW682OT7KljjLHr6x_
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030147
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

On Wed, 2022-11-02 at 14:45 -0400, Stefan Berger wrote:
> This series of patches fixes memory leaks related to tpm_bank_info
> allocations and entry.template as well as gcc compiler warnings
> when building with -fanalyzer (gcc 12.2.1).
> 
> This series is intended to be applied on top of Mimi's current series
> at https://github.com/mimizohar/ima-evm-utils/tree/next-testing .

Thank you for the cleanup.  Aside from the missing patch descriptions
(1/4, 2/4), the patch set looks good.  It applied cleanly on top of the
"misc bug and other fixes" patch set and Tergel's "support for reading
per bank TPM 2.0 PCRs via sysfs" patch, which are now in next-testing.

-- 
thanks,

Mimi

