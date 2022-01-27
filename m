Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7521349D7EF
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jan 2022 03:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbiA0CTW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 21:19:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234896AbiA0CTW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 21:19:22 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20R1lsZo027966;
        Thu, 27 Jan 2022 02:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Mzl41XpXzpO2lLy47QbOh3uvKRi2UezMNbgO7obqdes=;
 b=XwdDCM2R77upJowuJirnyq60cUWinkzT5ge/aQCNoGJ/2UWBAt130PFHATPissiavnAf
 oD/Hi4QOPdSDI8QGtuklN3E7sF8cRdRaokR99RL01STeEUy/N3DHotrRKHpLuZk9qqAh
 cGF59l+uDVN3ObgwM/rGorDcwgdY5xEeBQTA2R1QRzIjv9ez5Hs9pWZWuMCJ+2Q5wtJ/
 9lbI10BPSELYSbbyrUfMOu27Pc+3KYMYHXIhP7fE0rO15yJCua2sb8D6HKZHmeKaJR78
 NuxRg0c2SSbstbW4TkPA+jpvT37cJdrbq/g0CfyDIYS+lnXMB0NO1MuV5wOVFUoOxp1s wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3duj1wrhe1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 02:19:15 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20R2FIF1027703;
        Thu, 27 Jan 2022 02:19:15 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3duj1wrhdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 02:19:15 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20R2CDe1019117;
        Thu, 27 Jan 2022 02:19:13 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3dr9j9k0hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 02:19:12 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20R2JAcn37093854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 02:19:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83D00AE04D;
        Thu, 27 Jan 2022 02:19:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2888EAE045;
        Thu, 27 Jan 2022 02:19:09 +0000 (GMT)
Received: from sig-9-65-92-33.ibm.com (unknown [9.65.92.33])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jan 2022 02:19:09 +0000 (GMT)
Message-ID: <f87e6cef510013e3a7ce2ce31a444767650f9fdf.camel@linux.ibm.com>
Subject: Re: [PATCH v4] integrity: check the return value of
 audit_log_start()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Xiaoke Wang <xkernel.wang@foxmail.com>
Cc:     paul <paul@paul-moore.com>, jmorris <jmorris@namei.org>,
        serge <serge@hallyn.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 26 Jan 2022 21:19:08 -0500
In-Reply-To: <tencent_0685FF3C104366D05C368E2E0A88F043A507@qq.com>
References: <tencent_0685FF3C104366D05C368E2E0A88F043A507@qq.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nAgn9JSimx0DnyB3xEfGDNx9xmSrX3ax
X-Proofpoint-GUID: eKkt6vatNwETBYJqhT6FJ32m5mTQm3u6
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_09,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=799 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270011
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Xiaoke,

On Thu, 2022-01-27 at 09:59 +0800, Xiaoke Wang wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> audit_log_start() returns audit_buffer pointer on success or NULL on
> error, so it is better to check the return value of it.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> Reviewed-by: Paul Moore <paul@paul-moore.com>

Thanks, this patch is staged in the next-integrity-testing branch 
https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/

Mimi

