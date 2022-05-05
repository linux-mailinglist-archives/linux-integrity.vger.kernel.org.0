Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954D051BFA5
	for <lists+linux-integrity@lfdr.de>; Thu,  5 May 2022 14:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358905AbiEEMo3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 May 2022 08:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377632AbiEEMnz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 May 2022 08:43:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B743BDE;
        Thu,  5 May 2022 05:40:14 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245Bg3Xw015706;
        Thu, 5 May 2022 12:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Ks6pYfzwIPhTp1sognpwdkSoA5PQDLGHHd0QN8T6+hY=;
 b=mVjoeuaqKck8rz1dceuTdo6jKSdO5d8lqRGQJVI/qb9PUB8REgS339i+PXIgUasdGNTJ
 evkpPUh8eEcXyC1uFI8cZ0UzVmz9y/03tQqPlCuOXHL2v9o44h1r+aONlviMdvpqNa6K
 F8WZXt/mL4m0gNa6pkoaiVBJ77+ys7txi34cn2b3rFtW2W0jz8h22hhMRzJ6daoCDwXK
 BE5Qzr7I1CBepXHUg7k/o83+tcV7XxMqpSjWq7bjyweV1LmjqtYzf/Y094tXr6ZS6Pi+
 zLGXAXzom8k2aBWve21sh+s1YC2lxVePMen+qGKhkw7VdoU0FBEaIt+4jjvXlSp4nMs7 Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fvdxbs4vj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 12:40:06 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 245CHevX023064;
        Thu, 5 May 2022 12:40:06 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fvdxbs4ty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 12:40:06 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 245CcfxP017432;
        Thu, 5 May 2022 12:40:03 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3frvr8y729-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 12:40:03 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 245Cdui534669024
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 May 2022 12:39:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 649CD52051;
        Thu,  5 May 2022 12:40:01 +0000 (GMT)
Received: from sig-9-65-81-94.ibm.com (unknown [9.65.81.94])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7164152050;
        Thu,  5 May 2022 12:40:00 +0000 (GMT)
Message-ID: <f7d8ebad78e184dd391b920f72ed7a49d3e14aa3.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] ima: remove the IMA_TEMPLATE Kconfig option
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Guozihua (Scott)" <guozihua@huawei.com>,
        linux-integrity@vger.kernel.org
Cc:     dmitry.kasatkin@gmail.com, roberto.sassu@huawei.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 05 May 2022 08:39:59 -0400
In-Reply-To: <1f40a55b-7489-5e87-3584-73e2b1948615@huawei.com>
References: <20220407021619.146410-1-guozihua@huawei.com>
         <20220407021619.146410-2-guozihua@huawei.com>
         <fbc9cda8eacc0a701d7b336bf45ecb6dfd450be9.camel@linux.ibm.com>
         <1f40a55b-7489-5e87-3584-73e2b1948615@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9cQlf0iSe6D5WwgOw4f-6EzQQyitWHPU
X-Proofpoint-GUID: 3jzMLRszO8yu8gk7R7IleO0E1xufR-fE
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_05,2022-05-05_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 bulkscore=0 impostorscore=0
 mlxscore=0 adultscore=0 mlxlogscore=790 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205050091
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-05-05 at 09:35 +0800, Guozihua (Scott) wrote:
> Hi,
> 
> Is this patch picked?

Yes, the patch is queued in next-integrity, which feeds into linux-
next.  For the future, you can check 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git.

-- 
thanks,

Mimi

