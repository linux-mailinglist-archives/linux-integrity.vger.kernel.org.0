Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E11649BF5E
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 00:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbiAYXII (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jan 2022 18:08:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230468AbiAYXII (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jan 2022 18:08:08 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PLGgFO031800;
        Tue, 25 Jan 2022 23:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=pOhrnt5wieDar9QQaD1GP7nqP7TDKPRP+LaBd8lbFEY=;
 b=s+Vvtv+tqzHCyTUT5HbLNYX5Wv9kHHn9IK9kjoyQUntl0k6feP31j7OHBlP0ISfTgFln
 JtwdOzKh8TZYJxZNr4kHMkBNWLypJXavNNyAJT/lxP4bfKUCNadbdQ3glWBSYYff1vF4
 Z9q5DA7R1/nSXrwnCKKtdYwvwh92BPQvs8M20nBKomHDDjQBCNNiuE4max9Zzra3xUzS
 BMQeO5ehe8WYeKt3aTMWLhtYWGH7DBwQBRKBlhI9kRAgH1qlGj9QgqIgVZa7U6+r2wIK
 9gGpkWjo5BhJ6/LxVwXECgWz9UhPyrGi0qwHRn0tarZMXKEe/rSXOm1ggnC0DEJ0VsLs Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dtryvsts4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 23:08:05 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20PMtbQh029940;
        Tue, 25 Jan 2022 23:08:05 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dtryvstrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 23:08:05 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20PN3Kqd007279;
        Tue, 25 Jan 2022 23:08:03 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3dr96jgpf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 23:08:03 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20PMwR1d47907076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 22:58:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C7C152050;
        Tue, 25 Jan 2022 23:08:01 +0000 (GMT)
Received: from sig-9-65-78-94.ibm.com (unknown [9.65.78.94])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 784635204E;
        Tue, 25 Jan 2022 23:08:00 +0000 (GMT)
Message-ID: <bcb59cb4d8af33fe666acc8648ded424dbbc7370.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] ci/travis: Replace groovy -> impish
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>
Date:   Tue, 25 Jan 2022 18:07:59 -0500
In-Reply-To: <20220121164748.6536-1-pvorel@suse.cz>
References: <20220121164748.6536-1-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qGBQw0Z-adIPN5qqDg8HldtDjvWyITrG
X-Proofpoint-ORIG-GUID: AM0Rbgmqi0NoGpbV91GJZ_QzgXbMPIUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_06,2022-01-25_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=672 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250139
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Fri, 2022-01-21 at 17:47 +0100, Petr Vorel wrote:
> From: Petr Vorel <petr.vorel@gmail.com>
> 
> follow previous commit also for Travis.
> 
> Fixes: 024c02d ("ci: Replace groovy -> impish")
> 
> Reported-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
> Update only for Travis, as previous patch has been merged.

I had picked up your v2 1/1 version, which updated both.

thanks,

Mimi

