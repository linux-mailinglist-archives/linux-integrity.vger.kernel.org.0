Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2011867FF9F
	for <lists+linux-integrity@lfdr.de>; Sun, 29 Jan 2023 15:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjA2Oxa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 29 Jan 2023 09:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjA2Ox3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 29 Jan 2023 09:53:29 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B266E9D;
        Sun, 29 Jan 2023 06:53:29 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30TCv8Ib025247;
        Sun, 29 Jan 2023 14:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=BTymnEY7PdY80oj3gRAnHrWAC+GyrmyhWWU2S+Zj73M=;
 b=RFoFGx9pwVVxGyIk1MddbV0KLfpN9U41KpQ9FxTmLnwqQI4sCebFLvbFp8hajQXLvYge
 aonnbfbixryzO+/n8WzpKkLR/e8HNlNEZcF24GOi5A08UzfqJrtUJQSGldzlGhvMtUzc
 UeI9pvf1yCdpdmXi/prILbmc5yHQURhl5rYhFGOplMI1NYy6K/9pZtl+IWBYJ/t4HDK0
 5yrahFMspYjI3O30721zg0pRNb4xvw8f48GhMcq5O5p8RAwkG1CkZ81mB8tgX/e9lwsG
 Rh5M9vB8qXDCEVGnLOfvZ1d+er0GPTIKjMNwBZfU8pxTVV1OFaMNZNbyoyD4Q/ahVRVZ ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ndd5gtsu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 14:52:56 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30TEqtQu003193;
        Sun, 29 Jan 2023 14:52:55 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ndd5gtsu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 14:52:55 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30TDoI61028521;
        Sun, 29 Jan 2023 14:52:54 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3ncvuy6c2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 14:52:54 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30TEqrV27144064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Jan 2023 14:52:53 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DA3D5805C;
        Sun, 29 Jan 2023 14:52:53 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C10058051;
        Sun, 29 Jan 2023 14:52:52 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.14.97])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 29 Jan 2023 14:52:52 +0000 (GMT)
Message-ID: <89a7cc7efe1545e18c9af6c3ec53468d6f528a7a.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/2] ima: Introduce MMAP_CHECK_REQPROT hook
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanb@linux.ibm.com,
        viro@zeniv.linux.org.uk, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Sun, 29 Jan 2023 09:52:51 -0500
In-Reply-To: <20230126163812.1870942-2-roberto.sassu@huaweicloud.com>
References: <20230126163812.1870942-1-roberto.sassu@huaweicloud.com>
         <20230126163812.1870942-2-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BS8bjdh3i4i2-dHgYMWyer4ug3yZgapU
X-Proofpoint-ORIG-GUID: WUP_hBEkzHovIyANyxgtmqdLjZUXpGux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-29_09,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 suspectscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301290143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-01-26 at 17:38 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Commit 98de59bfe4b2f ("take calculation of final prot in
> security_mmap_file() into a helper") caused ima_file_mmap() to receive the
> protections requested by the application and not those applied by the
> kernel.
> 
> After restoring the original MMAP_CHECK behavior with a patch, existing
> systems might be broken due to not being ready to handle new entries
> (previously missing) in the IMA measurement list.

Is this a broken system or a broken attestation server?  The
attestation server might not be able to handle the additional
measurements, but the system, itself, is not broken.

"with a patch" is unnecessary.

> 
> Restore the original correct MMAP_CHECK behavior instead of keeping the

^ add missing comma after "behavior"

> current buggy one and introducing a new hook with the correct behavior. The
> second option 

^ The second option -> Otherwise,

> would have had the risk of IMA users not noticing the problem
> at all, as they would actively have to update the IMA policy, to switch to
> the correct behavior.
> 
> Also, introduce the new MMAP_CHECK_REQPROT hook to keep the current
> behavior, so that IMA users could easily fix a broken system, although this
> approach is discouraged due to potentially missing measurements.

Again, is this a broken system or a broken attestation server? 

> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Otherwise, the patch looks good.

-- 
thanks,

Mimi

