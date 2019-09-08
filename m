Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0899EACF3F
	for <lists+linux-integrity@lfdr.de>; Sun,  8 Sep 2019 16:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfIHOUl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 8 Sep 2019 10:20:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26074 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbfIHOUl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 8 Sep 2019 10:20:41 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x88EHTZ6033275
        for <linux-integrity@vger.kernel.org>; Sun, 8 Sep 2019 10:20:39 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uv7c1u1b8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 08 Sep 2019 10:20:39 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 8 Sep 2019 15:20:37 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 8 Sep 2019 15:20:34 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x88EKX1h45941156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 8 Sep 2019 14:20:33 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E962A4064;
        Sun,  8 Sep 2019 14:20:33 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74C77A405F;
        Sun,  8 Sep 2019 14:20:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.159.93])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  8 Sep 2019 14:20:32 +0000 (GMT)
Subject: Re: KEYS-TRUSTED git
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     jejb@linux.ibm.com, dhowells@redhat.com, sumit.garg@linaro.org
Date:   Sun, 08 Sep 2019 10:20:31 -0400
In-Reply-To: <c253ca7292b397f1352d2ee00fce0b011f84abff.camel@linux.intel.com>
References: <c253ca7292b397f1352d2ee00fce0b011f84abff.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19090814-0016-0000-0000-000002A85A3A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090814-0017-0000-0000-00003308D848
Message-Id: <1567952431.4614.140.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-08_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909080157
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2019-09-08 at 03:10 +0300, Jarkko Sakkinen wrote:
> It seems that at least vast majority of the trusted keys patches flow
> through my tree to the mainline. Still, it is undocumented in the
> MAINTAINERS file.
> 
> So, should I just add my TPM tree as the upstream there? Or should I
> just create a new GIT for trusted keys? My TPM PR goes to Linux ATM.
> Should my trusted keys PR go to David instead? That would definitely
> require own tree.
> 
> With Sumit's recent work trusted keys is turning more than just being
> TPM keys so now it is a good time to consider the flow... Sumit, I'm
> sorry that I haven't added your first series yet. I need to first sync
> up how we are going to move forward.

Thanks, Jarkko.  Agreed, trusted keys is becoming more than just TPM
based keys.  Now would be a good time to set up at least a separate
branch or GIT repo.

Are all "trust" methods equivalent?  As new "trust" methods are
defined, there should be a document describing the trust method, with
a comparison to the TPM.

(It would be nice to have some kernel selftests to ensure existing
methods don't break.)

Mimi

