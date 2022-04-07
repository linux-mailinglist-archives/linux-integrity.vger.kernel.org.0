Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4BD4F7F6A
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Apr 2022 14:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245391AbiDGMtG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Apr 2022 08:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245389AbiDGMtF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Apr 2022 08:49:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C027E5A5;
        Thu,  7 Apr 2022 05:47:04 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 237CflWE022118;
        Thu, 7 Apr 2022 12:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=joPMwLoNAohCU3AInhV9r4dWEXIX77OEcC2bPJ3D/JA=;
 b=Fy6NxTb8+yINWVsoR+bh25miUPx1JVy4af6mfANw7ooBFDrS+JZQzduOAgt9dPJhy3Dh
 2J82g1v1P8CAILGy/cvXio8Naa1cqhxZmjxBO8BPTLQQ0+mHBRXTIrJU86hSYBIzBblY
 ygt/rXPuAk3sXkD8DNmlaDitfkNTGxAOHbQ6zYUjZrI9/Qy7PNWOpwEJjktKtY70RLVf
 9CrK6Z0E0khnpkAmhHHaxe+LonAuSrXv0bGvTh4UY++Nz2hvrg12NmmfA5w4PAljDUVn
 wp4B8CT/b5h/hvvmelQZoTzXN3WJpgCPVo+6sAE/zm59CxwkfvWSKuvrst+Ig5FQsl5v HA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f9w8vbk2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 12:46:56 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 237Cis4A027687;
        Thu, 7 Apr 2022 12:46:55 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f9w8vbk1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 12:46:55 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 237CXeMp030670;
        Thu, 7 Apr 2022 12:46:53 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3f6e491wc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 12:46:53 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 237CkpAo40501718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Apr 2022 12:46:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48AF2A404D;
        Thu,  7 Apr 2022 12:46:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 419C0A4040;
        Thu,  7 Apr 2022 12:46:50 +0000 (GMT)
Received: from sig-9-65-64-98.ibm.com (unknown [9.65.64.98])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Apr 2022 12:46:50 +0000 (GMT)
Message-ID: <d4ac7695a9a2be9750c62218bb3c262d28367208.camel@linux.ibm.com>
Subject: Re: [PATCH v3 0/1] ima: fix boot command line issue
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     GUO Zihua <guozihua@huawei.com>, linux-integrity@vger.kernel.org
Cc:     dmitry.kasatkin@gmail.com, roberto.sassu@huawei.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 07 Apr 2022 08:46:49 -0400
In-Reply-To: <20220407021619.146410-1-guozihua@huawei.com>
References: <20220407021619.146410-1-guozihua@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CV9jpD3xNsFOsf6FNmwkpIpAOH_V783l
X-Proofpoint-GUID: -oc9aErTMu2IKK7B6bMEvB-YP5AP_7Sk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-07_01,2022-04-07_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 mlxscore=0 clxscore=1015 phishscore=0
 malwarescore=0 mlxlogscore=914 adultscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2204070063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-04-07 at 10:16 +0800, GUO Zihua wrote:
> Change log:
>   v3:
>     Update commit message following Mimi's advice, update comments for
>     config.
>   v2:
>     update commit message and subject following Mimi's advice. Remove
>     references for CONFIG_IMA_TEMPLATE as well.

For future referece, the change log can be added after the break line
(---) in the patch itself.  No need for a cover letter for a single
patch.

thanks,

Mimi


