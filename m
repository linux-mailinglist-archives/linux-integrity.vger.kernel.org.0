Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0A5492E70
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jan 2022 20:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbiARTZp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jan 2022 14:25:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234118AbiARTZo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jan 2022 14:25:44 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IGv7qu029915;
        Tue, 18 Jan 2022 19:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=UwyAcXVWKaAfxqGWoBeT1xuHVamkwWvT/vPaONb3+5s=;
 b=FHHlD5Pce8IkdV18XdGZdO1+4YwwdPPvwaL11gRIfTtRi+0tKaFmDSXkLC1ri9s3MUSf
 3geDW5cg1EKHxIZSGeiyOsZYUO2i0j7uVLowuLVZUcpLF8pWmtZgXIZzyZs4e34sUqA9
 qJ3wxYQApNsr1PfDjGT9fW5QAg1qjXMaq4JMVSMEihUiyLy5KfnOj62FNZF30HKCv2sj
 7O/4youSQP9IyvppWisqBTNxDfnheI9atLkkxkGgMiE+8lU0AfujgtCohxYYsfdQEHI2
 CRoKNBEXwAoS9k67x2pt772ArgXbqih6GM5o21V/v1lRGs0QZe8pz7yGihRbcke2/Ug2 oA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dp1h8c8q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 19:25:42 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20IJH3cv012052;
        Tue, 18 Jan 2022 19:25:42 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dp1h8c8pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 19:25:41 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20IJHI4x022954;
        Tue, 18 Jan 2022 19:25:40 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3dnm6r743y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 19:25:40 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20IJGKHx47841536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 19:16:20 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C60AC11C066;
        Tue, 18 Jan 2022 19:25:37 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CE3811C05C;
        Tue, 18 Jan 2022 19:25:37 +0000 (GMT)
Received: from sig-9-65-88-194.ibm.com (unknown [9.65.88.194])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Jan 2022 19:25:37 +0000 (GMT)
Message-ID: <ac7ec9f55a7a5fa63bfdd8bc933dde42e1d8142f.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] ci: Replace groovy -> impish
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>
Date:   Tue, 18 Jan 2022 14:25:36 -0500
In-Reply-To: <20211231222916.12994-1-pvorel@suse.cz>
References: <20211231222916.12994-1-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pW0I0sSZ9pmYjLbYDdLErVqUvtx0a-sK
X-Proofpoint-GUID: YLYnsKCWFHt9zC_-hkte6lHUKAd5cF2q
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-18_05,2022-01-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 mlxlogscore=777 priorityscore=1501 impostorscore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180113
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Fri, 2021-12-31 at 23:29 +0100, Petr Vorel wrote:
> From: Petr Vorel <petr.vorel@gmail.com>
> 
> groovy is EOL, which is probably the reason why it's archives has been
> removed:
> 
> Ign:1 http://security.ubuntu.com/ubuntu groovy-security InRelease
> Ign:2 http://archive.ubuntu.com/ubuntu groovy InRelease
> Err:3 http://security.ubuntu.com/ubuntu groovy-security Release
>   404  Not Found [IP: 91.189.91.39 80]
> Ign:4 http://archive.ubuntu.com/ubuntu groovy-updates InRelease
> Ign:5 http://archive.ubuntu.com/ubuntu groovy-backports InRelease
> Err:6 http://archive.ubuntu.com/ubuntu groovy Release
>   404  Not Found [IP: 91.189.88.142 80]
> Err:7 http://archive.ubuntu.com/ubuntu groovy-updates Release
>   404  Not Found [IP: 91.189.88.142 80]
> Err:8 http://archive.ubuntu.com/ubuntu groovy-backports Release
>   404  Not Found [IP: 91.189.88.142 80]
> Reading package lists...
> E: The repository 'http://security.ubuntu.com/ubuntu groovy-security Release' does not have a Release file.
> E: The repository 'http://archive.ubuntu.com/ubuntu groovy Release' does not have a Release file.
> E: The repository 'http://archive.ubuntu.com/ubuntu groovy-updates Release' does not have a Release file.
> E: The repository 'http://archive.ubuntu.com/ubuntu groovy-backports Release' does not have a Release file.
> 
> Using impish requires to use workaround to avoid apt asking to
> interactively configure tzdata.
> 
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>

Thanks, Petr.   A similar one line change needs to be made to
.travis.yml.  I've already tested it internally.  Do you mind including
in this patch?

thanks,

Mimi

