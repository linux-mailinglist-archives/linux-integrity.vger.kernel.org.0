Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EF348DEE9
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jan 2022 21:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiAMU2o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jan 2022 15:28:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13104 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232027AbiAMU2o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jan 2022 15:28:44 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20DJqR61013831;
        Thu, 13 Jan 2022 20:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=vU55w08HP4Jjmt31o+34tXqsjlmZRQiUsSn3bKom+tw=;
 b=ZU+YmFTdcyIlKsu9HMwfGWeUeoxmeZ5+iOoHshji+3a7WxWVTIEGA9js9fkD/PV/vt65
 kGFA0ePZkxZ1evWjBmNdEKt8xRpOMFNq019DXSpJezLAbcakbajtx8UmHVJ48UVk6+5D
 UqA7DvgwrLCq9Ejv3yQxQpzYZIWCGGXS8shj7H2VG6YQ0sp4YJkE1U2hysGrt1KiXHkO
 LQaCGtpDfxmtbSxUqhQqG7zmcLqrsPPF1/EgJHoDdPAi9u5ydTY3nzhVVGkyZtFDy9fM
 48zy5rv4qbLjlvK8EU8ZDEMicUga1ky+H0yykOPXc9/DoFAnmqhkou3EZafhLQExKu2n rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3djtme0v9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 20:28:30 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20DJrk2T016467;
        Thu, 13 Jan 2022 20:28:30 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3djtme0v8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 20:28:30 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20DKRO7F031747;
        Thu, 13 Jan 2022 20:28:27 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3df289wy8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 20:28:26 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20DKSMm826476950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 20:28:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90A244C07A;
        Thu, 13 Jan 2022 20:28:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A510A4C070;
        Thu, 13 Jan 2022 20:28:19 +0000 (GMT)
Received: from sig-9-65-68-109.ibm.com (unknown [9.65.68.109])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jan 2022 20:28:19 +0000 (GMT)
Message-ID: <e3fdefb5517193326b963847ac5e893531fb3dbd.camel@linux.ibm.com>
Subject: Re: [PATCH v8 08/19] ima: Use mac_admin_ns_capable() to check
 corresponding capability
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Denis Semakin <denis.semakin@huawei.com>
Date:   Thu, 13 Jan 2022 15:28:19 -0500
In-Reply-To: <20220104170416.1923685-9-stefanb@linux.vnet.ibm.com>
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
         <20220104170416.1923685-9-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AnVEkgGNtHt4VoRqMAqXG1KEjd-iPvkU
X-Proofpoint-ORIG-GUID: BiOUPvfoFXEEsJ47wcDmu32scz97lIUK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_09,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201130126
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan, Denis,

mac_admin_ns_capable() is being introduced in this patch.  Either
rename the "Subject" line as "ima: replace capable() call with
ns_capable()" or "ima: define mac_admin_ns_capable() as a wrapper for
ns_capable()".

On Tue, 2022-01-04 at 12:04 -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Use mac_admin_ns_capable() to check corresponding capability to allow
> read/write IMA policy without CAP_SYS_ADMIN but with CAP_MAC_ADMIN.

Updatethe patch description accordingly.

> 
> Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

thanks,

Mimi

