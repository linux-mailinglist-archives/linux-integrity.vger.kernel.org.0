Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108394B7700
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Feb 2022 21:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241184AbiBOSJ6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Feb 2022 13:09:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbiBOSJ6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Feb 2022 13:09:58 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C88119431;
        Tue, 15 Feb 2022 10:09:47 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FHB2pG016332;
        Tue, 15 Feb 2022 18:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=9kxFY6QSfERb8ypvZ0/M23Sv+S4WIy8ZmOdiGOw/q4I=;
 b=X4yaxXOc2a/6q/fjuObGtyNqKwxDYUzXn/K9HnUzHUz62EIENYgCz55If95TQfjnod70
 LW8CSsvQcTKSolAKi7RlJPfj/y7H29w/Ot5JX7y9LtScIacl8aouZ5zg01dWXEG8G6tE
 tN3j1hkvQubd9O0+zLnlPSI2C42V6OBvRK2kkjQb4LomKYRZXvl0eu5SEWFKYgC+6mmQ
 bLpi809lXPQ/jhHSDkyr9TbQku9jTfjVx8qsCshOHNcOSRjX8NNJ8avVfxo3LUJiZQ27
 Mv6LFhy7f4+kYFmr4/G95Qtt8PjqT9biwwwaih96KwgUZtETBY34XmVCulwgiiPWoToT Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e8fe3tmfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 18:09:12 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21FHDv5W026458;
        Tue, 15 Feb 2022 18:09:12 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e8fe3tmer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 18:09:12 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21FI8UFm001039;
        Tue, 15 Feb 2022 18:09:10 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3e64ha1vkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 18:09:10 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21FI95ce42205450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 18:09:05 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 576C611C06C;
        Tue, 15 Feb 2022 18:09:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34D4711C054;
        Tue, 15 Feb 2022 18:09:03 +0000 (GMT)
Received: from sig-9-65-88-149.ibm.com (unknown [9.65.88.149])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Feb 2022 18:09:03 +0000 (GMT)
Message-ID: <8d72ee39ac5d98e0d293d46c8f73188281f270b7.camel@linux.ibm.com>
Subject: Re: [PATCH v10 03/27] ima: Return error code obtained from
 securityfs functions
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
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Tue, 15 Feb 2022 13:09:02 -0500
In-Reply-To: <1a4bc3cf915057bc5c5957c42c164bc2491a9da7.camel@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
         <20220201203735.164593-4-stefanb@linux.ibm.com>
         <1a4bc3cf915057bc5c5957c42c164bc2491a9da7.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2vQN03Yr0BkbDFMnNTjyktEts2coJDFe
X-Proofpoint-ORIG-GUID: CIupRnnEGM9sDcVqfp0CKLZMLJCOh7PS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_05,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=953
 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150105
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-02-10 at 07:02 -0500, Mimi Zohar wrote:
> On Tue, 2022-02-01 at 15:37 -0500, Stefan Berger wrote:
> > If an error occurs when creating a securityfs file, return the exact
> > error code to the caller.
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> Thanks, Stefan.  Nice cleanup.

This is now queued in next-integrity.

-- 
Thanks,

Mimi

