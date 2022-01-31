Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51504A5379
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Feb 2022 00:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiAaXnx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Jan 2022 18:43:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229721AbiAaXnw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Jan 2022 18:43:52 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VNcagq027610;
        Mon, 31 Jan 2022 23:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=QDBpzUi3ZY1eikTOFV3lYd5DAOwGomSFhKa5tX6DqG0=;
 b=Wjo5CnJe00YwVcSCj7Ch+zMlETbSXRXO4Iqcj/o9mKv8+FBfKHQjTMP95ClgRxl7m6bO
 d0JDfFZEVWLIZteSojfnjr9IrF0ZzrJca61Pi+Ug/jz5sun/CDRTBU7MN/jX+x5aIMfY
 PgabrLUa44mPHO/3+gP1NhbGIaKjfyfcBElzpeIFywCYWM8UlOg74V3CALD1TIGlqoQy
 G7scCS8j1wKESmg5PVdJrvNyIh/BA8PbIpoC4XySGUxIq6LM9EcY8LTOwCGdxc5f7FqZ
 9Dn44VxGsKZ5UJwK55PC/WyYjTUK0bSbPsZ6CF4Iwuqs72R6V+4T8BqTiEd7wJjy9hkZ pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dxm8dy0n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 23:43:22 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20VNhMgW020606;
        Mon, 31 Jan 2022 23:43:22 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dxm8dy0mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 23:43:22 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20VNIPgu003180;
        Mon, 31 Jan 2022 23:43:19 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3dvw79fnfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 23:43:19 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20VNhFlU31654292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 23:43:16 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEE8542045;
        Mon, 31 Jan 2022 23:43:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAA6A42041;
        Mon, 31 Jan 2022 23:43:12 +0000 (GMT)
Received: from sig-9-65-69-222.ibm.com (unknown [9.65.69.222])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 31 Jan 2022 23:43:12 +0000 (GMT)
Message-ID: <b811c99ee635704cf42cf35dbe9df15460df9c1f.camel@linux.ibm.com>
Subject: Re: [PATCH v9 04/23] securityfs: Extend securityfs with namespacing
 support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christian Brauner <brauner@kernel.org>
Date:   Mon, 31 Jan 2022 18:43:12 -0500
In-Reply-To: <d31e8276-9303-fff8-427f-afc859131202@linux.ibm.com>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
         <20220125224645.79319-5-stefanb@linux.vnet.ibm.com>
         <dc60e85030ac6423fb2af7361d9e47b01f8c63f7.camel@linux.ibm.com>
         <d31e8276-9303-fff8-427f-afc859131202@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FjEF1v7r_J3fddyO-XoFlYiTF9Uskek7
X-Proofpoint-GUID: -YqOWc-yNNSxk7jckltKzx6mptrzUvFU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_07,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310144
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2022-01-31 at 17:28 -0500, Stefan Berger wrote:
> On 1/27/22 11:53, Mimi Zohar wrote:
> > On Tue, 2022-01-25 at 17:46 -0500, Stefan Berger wrote:
> >> From: Stefan Berger <stefanb@linux.ibm.com>
> >>
> >> Enable multiple instances of securityfs by keying each instance with a
> >> pointer to the user namespace it belongs to.
> >>
> >> Since we do not need the pinning of the filesystem for the virtualization
> >> case, limit the usage of simple_pin_fs() and simpe_release_fs() to the
> >> case when the init_user_ns is active. This simplifies the cleanup for the
> >> virtualization case where usage of securityfs_remove() to free dentries
> >> is not needed anymore.
> > Could you add a sentence here explaining why securityfs_remove() isn't
> > needed in the virtualization case?
> 
> At this point the reason is that simple_pin_fs() is not used for the 
> virtualization case.
> 
> Maybe it should say: ... to free dentries is *therefore* not needed anymore.

Probably it's obvious, but I was looking for something along the lines
of, "The securityfs file or directory is automatically removed based on
reference count."

No need to update it.

thanks,

Mimi

