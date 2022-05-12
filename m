Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F9B5257BB
	for <lists+linux-integrity@lfdr.de>; Fri, 13 May 2022 00:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbiELWZG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 May 2022 18:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359132AbiELWZF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 May 2022 18:25:05 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B0C28134E
        for <linux-integrity@vger.kernel.org>; Thu, 12 May 2022 15:25:04 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CMEweU014175;
        Thu, 12 May 2022 22:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=fGR4jUNMpnAmwsZ3CjeGeB00Pk9QIRbplwHFl/ZRMc4=;
 b=OYksrWF0iGY6M4xCm+ZgZ03uZx0gWa6sH8thnnFmEEVzSDHyBsBnUZGajdTJuJ4/PcVN
 6Uhzv4uyDuJPElLN+2fg5mJVeOZ1n6DirZi0tlV81faETGxspTD3wD1ugWFCLBUsKPCl
 bkyQlSz5rDj7MYu91vUXucBJNxyIhm2buzs5ayX4TwxPQTTBz+pOefdv42BmeH4GRzNd
 djTJ6ky+NgeQiagQDnBdRy8yD1m47Zrvympay4JfTZdIYcYRtqJYoksoNDdyZ7gAOMN4
 Immy4Fau5rHj4i1BPsPegx5j8Ve41GVfcwr++Z5vWnVxB5x09drkZZIBQbvf6Zcp6DtD rQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1av704e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 22:25:01 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CMOprb027070;
        Thu, 12 May 2022 22:24:59 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3fwgd8wyfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 22:24:59 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CMOudj51773708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 22:24:56 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2927E11C05B;
        Thu, 12 May 2022 22:24:56 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CF8711C04C;
        Thu, 12 May 2022 22:24:55 +0000 (GMT)
Received: from sig-9-65-84-154.ibm.com (unknown [9.65.84.154])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 May 2022 22:24:55 +0000 (GMT)
Message-ID: <ec7887c8f476fcadd01133a4d50a2b24d1250711.camel@linux.ibm.com>
Subject: Re: [PATCH v2 ima-evm-utils 1/3] initialize errno in cmd_sign_hash()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Eric Biggers <ebiggers@kernel.org>
Date:   Thu, 12 May 2022 18:24:54 -0400
In-Reply-To: <5a5ff8ae-f99a-e717-bdd4-601774f1692e@linux.ibm.com>
References: <20220512183056.307597-1-zohar@linux.ibm.com>
         <5a5ff8ae-f99a-e717-bdd4-601774f1692e@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U-INanTsXGfS0HpY5Kgfy_cqsg1gyVQ_
X-Proofpoint-GUID: U-INanTsXGfS0HpY5Kgfy_cqsg1gyVQ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_17,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 clxscore=1015 spamscore=0 impostorscore=0 mlxlogscore=904 malwarescore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120094
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-05-12 at 15:14 -0400, Stefan Berger wrote:
> 
> On 5/12/22 14:30, Mimi Zohar wrote:
> > Prevent "errno: No such file or directory (2)" message.
> 
> I guess there's an error being returned from call_command() but this 
> errno is unrelated or confusing. Maybe errno should be initialized at 
> the beginning of main() or beginning of call_command() to clear it 
> before any command is run that can return an error and where the errno 
> may be confusing the user otherwise.

'errno' is being set on failure to open/fopen and access() in
file_exist(). 

thanks,

Mimi

