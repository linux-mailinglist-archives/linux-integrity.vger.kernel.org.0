Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8493B36BE
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jun 2021 21:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhFXTWK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Jun 2021 15:22:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50300 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232370AbhFXTWK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Jun 2021 15:22:10 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15OJ53fx010195;
        Thu, 24 Jun 2021 15:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=gHVxzqqQQbLFXsy0D4+yQYHqfITHb3NqTS2D6vSraNA=;
 b=jpPsU1N66WZYn3Zof/ouFzGQxb448oDgaSy09cHMzzAslRRTKYl6AFHdrSgz7pT81NNs
 81n5CfEVTVWg/ba0/iZdU/hOgf9VZ+Qv+fXvPg4RPGLlNcy3ebg8CGxmCKqYvWDK/TyW
 +RVU74JO2tJpVG6J4xRx6uNeWpEh2+7YgTGQPE0QLzNIaRkFkQFFZHvM4XfP2FsYrWj9
 LrKzdfWx/cGsN+WIs0/PAUMV0xQMRXCYhUAqnmyWCS4s4q6vDfCbguYCNpwoVoQF4+Je
 9qTREnfEnmM3hpiiYOHUReEBmriz9WMWKVAyCH+v01Sy9VoiMi5jHp+3LD3k53zRsnit og== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39cvh57hw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 15:19:48 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15OJGMVq007553;
        Thu, 24 Jun 2021 19:19:46 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3997uhhgf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 19:19:46 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15OJILR835520806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 19:18:21 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62D5711C04A;
        Thu, 24 Jun 2021 19:19:44 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CE7211C04C;
        Thu, 24 Jun 2021 19:19:43 +0000 (GMT)
Received: from sig-9-65-196-119.ibm.com (unknown [9.65.196.119])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 24 Jun 2021 19:19:43 +0000 (GMT)
Message-ID: <c88c3a1e20242d4f42eea275a174f4b375e203bb.camel@linux.ibm.com>
Subject: Re: [PATCH 0/3] Add GitHub Actions support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Date:   Thu, 24 Jun 2021 15:19:42 -0400
In-Reply-To: <20210622141224.25006-1-pvorel@suse.cz>
References: <20210622141224.25006-1-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8TbOszYB5nKW-X8YQ3aSq_PK1nhiioHv
X-Proofpoint-ORIG-GUID: 8TbOszYB5nKW-X8YQ3aSq_PK1nhiioHv
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-24_12:2021-06-24,2021-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106240105
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-06-22 at 16:12 +0200, Petr Vorel wrote:
> Hi Mimi,
> 
> Travis is unreliable due "pull rate limit" issue, workaround does not
> work any more. Also GitHub Actions is a recommended way for projects
> hosted on GitHub.
> 
> Nice bonus is that manual podman activation for distros using glibc >=
> 2.33 (e.g. openSUSE Tumbleweed, Fedora) it's not needed in GitHub.
> 
> Unlike LTP, where I removed Travis CI support, I kept it for
> ima-evm-utils, because you use it.

Thanks, Petr.  I appreciate your not removing Travis CI.

I've pushed out the changes to next-testing.

Mimi

