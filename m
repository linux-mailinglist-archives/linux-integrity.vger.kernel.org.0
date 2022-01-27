Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11D349E81C
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jan 2022 17:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244145AbiA0QyU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Jan 2022 11:54:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237397AbiA0QyT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Jan 2022 11:54:19 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RGZsSq001939;
        Thu, 27 Jan 2022 16:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Ce9Om5zWjXg0EteTbjxkSHpDkkN7UXm4p7G83b6Q1Uk=;
 b=iCNHEp4ivvOG33HdgZ/8rAvo0MsQaHoUykjeuxewn1PH/RzOLNVIlPsGJNLEOlZ+Lvd3
 o8ue47Rbkcu0x3phUrEFi3pShoYttOROMoG2uX6Cy2OrtIC3O1ecYIJdNc/fmrCrhU3K
 GbiUDoVQK3ArTek0BH1uAUAsf/7AGATZcNi4k9iKsCNBxcoZrzdFmYGImkHCiMxRRbj7
 s3+gaDfbWPxWkSa1vdtDjZcetN19ghNKb7rhI1ox/Mi7uvIvge3U+sQNKxlKhvjED6VY
 FXZGtX7jGPVKs5YWx/3kNO1CICkFt0E0rlrdktStjtE0Ikfp8skuFKf1jr/swIQKDLpM SA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3duxqcgq0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 16:54:02 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20RGZvc4002506;
        Thu, 27 Jan 2022 16:54:01 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3duxqcgq05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 16:54:01 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20RGqYth013970;
        Thu, 27 Jan 2022 16:53:58 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3dr96k0437-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 16:53:58 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20RGrsb132571854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 16:53:54 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF5AE4C04E;
        Thu, 27 Jan 2022 16:53:54 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3E234C046;
        Thu, 27 Jan 2022 16:53:51 +0000 (GMT)
Received: from sig-9-65-89-165.ibm.com (unknown [9.65.89.165])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jan 2022 16:53:51 +0000 (GMT)
Message-ID: <dc60e85030ac6423fb2af7361d9e47b01f8c63f7.camel@linux.ibm.com>
Subject: Re: [PATCH v9 04/23] securityfs: Extend securityfs with namespacing
 support
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
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christian Brauner <brauner@kernel.org>
Date:   Thu, 27 Jan 2022 11:53:51 -0500
In-Reply-To: <20220125224645.79319-5-stefanb@linux.vnet.ibm.com>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
         <20220125224645.79319-5-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8X8LV2cn6gtRvbzlAndt8eZ2eDFxo7M3
X-Proofpoint-GUID: xe30xg-ad0VW6i6Gng07KNezKJ6TT9SP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270100
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-01-25 at 17:46 -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Enable multiple instances of securityfs by keying each instance with a
> pointer to the user namespace it belongs to.
> 
> Since we do not need the pinning of the filesystem for the virtualization
> case, limit the usage of simple_pin_fs() and simpe_release_fs() to the
> case when the init_user_ns is active. This simplifies the cleanup for the
> virtualization case where usage of securityfs_remove() to free dentries
> is not needed anymore.

Could you add a sentence here explaining why securityfs_remove() isn't
needed in the virtualization case?

> 
> For the initial securityfs, i.e. the one mounted in the host userns mount,
> nothing changes. The rules for securityfs_remove() are as before and it is
> still paired with securityfs_create(). Specifically, a file created via
> securityfs_create_dentry() in the initial securityfs mount still needs to
> be removed by a call to securityfs_remove(). Creating a new dentry in the
> initial securityfs mount still pins the filesystem like it always did.
> Consequently, the initial securityfs mount is not destroyed on
> umount/shutdown as long as at least one user of it still has dentries that
> it hasn't removed with a call to securityfs_remove().
> 
> Prevent mounting of an instance of securityfs in another user namespace
> than it belongs to. Also, prevent accesses to files and directories by
> a user namespace that is neither the user namespace it belongs to
> nor an ancestor of the user namespace that the instance of securityfs
> belongs to. Do not prevent access if securityfs was bind-mounted and
> therefore the init_user_ns is the owning user namespace.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Suggested-by: Christian Brauner <brauner@kernel.org>

Really nice!   A minor nit is that "Suggested-by" should go before your
"Signed-off-by".

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

