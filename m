Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0E035DE33
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Apr 2021 14:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344109AbhDMMDE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Apr 2021 08:03:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34082 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238034AbhDMMDD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Apr 2021 08:03:03 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DBX5Mv086301;
        Tue, 13 Apr 2021 08:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ifkBprtyWUXYfCOYa4U7gvP05gYG3xnjYflTQTMmyXM=;
 b=YttfGevvlGgLSo2wYxoQeWUUd9ULgp2VJ8ETl9qfLSikfUM84rKmkAzTLxbWJvhDlCOL
 RNKYkzA+XioKtZBTaqeG7RujvDjZPh4qxMW0ItXdajHz8Qn/Z+/FrM0V8G4GRG0bGpPu
 GkeO7Wt8NhmOuIiTyUxt7Wkn5FZ4TQFPFxv4Li5H02fGSNEZwju05SwmxlNVXk/6rWFo
 JOAjo9yBurjsvvcQ//lsvtdhGzicmRqOdBhv7ogWVzj4dYWxji42jCXcPZSPPTu8V/SB
 jExRjwgTO8O6gDIplBpRe2F8Tahlr7WQjAcGO2G7VnqAOU/eEa65szqGhfhbk4ac7q6L YQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37vjtu8k2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 08:02:41 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13DBxNgg024352;
        Tue, 13 Apr 2021 12:02:39 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 37u3n89d24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 12:02:39 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13DC2b8u37421448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 12:02:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06B3752057;
        Tue, 13 Apr 2021 12:02:37 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.135.168])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E25545204E;
        Tue, 13 Apr 2021 12:02:35 +0000 (GMT)
Message-ID: <b65400f3c4c54f74724247d111c46fbfea3183d4.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] travis: Fix openSUSE Tumbleweed
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Date:   Tue, 13 Apr 2021 08:02:34 -0400
In-Reply-To: <20210312114152.20475-1-pvorel@suse.cz>
References: <20210312114152.20475-1-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y2azSG4ytf68yPSNkTasY9eYwYhBCVS3
X-Proofpoint-ORIG-GUID: Y2azSG4ytf68yPSNkTasY9eYwYhBCVS3
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_04:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130081
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Fri, 2021-03-12 at 12:41 +0100, Petr Vorel wrote:
> openSUSE Tumbleweed build fails due broken permission detection due
> faccessat2() incompatibility in libseccomp/runc used in old docker with
> old kernel on Ubuntu Focal on hosts in Travis CI together with guests
> with the newest glibc 2.33.
> 
> Fixing Tumbleweed required switch to podman and downloading newest runc
> release (v1.0.0-rc93) which contains the fix [1], because proposed glibc
> fix [2] aren't going to merged to upstream [3] nor to Tumbleweed
> downstream glibc [4].
> 
> Using podman requires --no-same-owner tar option to workaround
> running out of subuids/subgids:
> tar: ./LICENSE: Cannot change ownership to uid 339315, gid 578953: Invalid argument
> (sudo would also work)
> 
> Sooner or later it will be required for more distros (Fedora, Debian
> Ubuntu), but don't waste build time until required.
> 
> [1] https://github.com/opencontainers/runc/pull/2750
> [2] https://sourceware.org/pipermail/libc-alpha/2020-November/119955.html
> [3] https://sourceware.org/pipermail/libc-alpha/2020-November/119978.html
> [4] https://bugzilla.opensuse.org/1182451
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

The mismatch seems to be when compiling with clang, at least on our
internal travis.  Compiling opensuse/tumbleweed with gcc works
fine.  Compiling opensuse/leap with clang is fine too.  Does that make
sense?

Mimi



