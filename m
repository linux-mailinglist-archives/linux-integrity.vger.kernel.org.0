Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD074B0D1A
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Feb 2022 13:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241317AbiBJMCr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Feb 2022 07:02:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240666AbiBJMCp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Feb 2022 07:02:45 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2853C104;
        Thu, 10 Feb 2022 04:02:47 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21AB51Lm031916;
        Thu, 10 Feb 2022 12:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=q3YJcjJUG1wHBDqkR7Coy4veQg6CzEtsNhvRR50bmig=;
 b=KWcmWNzxWR4SYNjAh+BEpyDk6idBa+OCf/NRDrAu4kxdemHuPbUCik+RPgeWRBGSdjaF
 kkXXq4XIw9gFPrt2qsQtv/z3GpqHtItkVNDI4M8/PJjaM+/bI7Lq67Du8VfUEMuUs3FY
 MSbX4QBtv8/wTUWzgvXadAHEpuLW7AmS2649GXR2Xbgqsd1ESMxy2lnFGQqQrJRX7OuA
 Lg/WySla/gnVjoZy8G/49xj5UMl/fucW6kCVu3zeqdt+gf0MF+3vuJC7G7IZZPPQyHmZ
 xoQBkFwghzxaSWxSL/UgRli8TDj3xAB/ZxCZIdzvrCEK/M7Hzqrl12EmZK8U6ata7pwI Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e4cb7cjy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 12:02:15 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21ABsP7C002670;
        Thu, 10 Feb 2022 12:02:14 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e4cb7cjxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 12:02:14 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21ABg9hR009295;
        Thu, 10 Feb 2022 12:02:12 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3e1gv9wm6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 12:02:12 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21AC284S45941184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 12:02:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D17D55205F;
        Thu, 10 Feb 2022 12:02:08 +0000 (GMT)
Received: from sig-9-65-78-200.ibm.com (unknown [9.65.78.200])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 09BB85204E;
        Thu, 10 Feb 2022 12:02:05 +0000 (GMT)
Message-ID: <13f0f8280512f9e109cbf26cbcb6e285e29996cf.camel@linux.ibm.com>
Subject: Re: [PATCH v10 01/27] ima: Remove ima_policy file before directory
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Christian Brauner <brauner@kernel.org>
Date:   Thu, 10 Feb 2022 07:02:05 -0500
In-Reply-To: <20220201203735.164593-2-stefanb@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
         <20220201203735.164593-2-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9s6bGFEg1dfWjAZ_eFgX_fYczrZwjECH
X-Proofpoint-GUID: aoq5XRVwyo8q9SVkKrRJhGPPylEhq32L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_05,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=950 phishscore=0 impostorscore=0
 mlxscore=0 spamscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202100066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

On Tue, 2022-02-01 at 15:37 -0500, Stefan Berger wrote:
> The removal of ima_dir currently fails since ima_policy still exists, so
> remove the ima_policy file before removing the directory.
> 
> Fixes: 4af4662fa4a9 ("integrity: IMA policy")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Christian Brauner <brauner@kernel.org>

Thanks, Stefan.  I've started picking off the bug fixes and upstreaming
them.  Both this patch and 2/27 are now in Linus' tree and should be in
-rc4.

-- 
Mimi

