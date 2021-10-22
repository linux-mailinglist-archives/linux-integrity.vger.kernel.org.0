Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49ED6437BF7
	for <lists+linux-integrity@lfdr.de>; Fri, 22 Oct 2021 19:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhJVRe1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 Oct 2021 13:34:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54972 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233653AbhJVRe0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Oct 2021 13:34:26 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MFGnDF011671;
        Fri, 22 Oct 2021 13:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=LGet4gWh6uuOfKai4o/ygLsRdjpy8G+X5B+4rb0PL7Q=;
 b=UpGC8iWc9gCDlpaUNL8dybendO09hmNF9xAUtsulp+G2yLL9iQA1bHreouend5R9Er2P
 kaEZj2HnDd2R3Ril8laz+IrwgfZdQ4UP3yCTx0ZzvNnK+1wQXausDGobu7dR73x/LiB7
 h14jjd7w0CfS5cIf+CfLdKJtUYBGYUJbyLFUBJz8PXzWDVm//1SCLj2PzGIlq8wUcKGZ
 8/4bQqLxV2dihnYb1TBqwnBYfAHibLC+9HeqEaVcH6wgAgOV86ES1aKb0Lu98Y1hU5Z+
 0R3+563RcIduA1PmqZ/h2H+YlY5lnzJeqAFbveB5XEC8S/V3zEe2ckSo0Gb3eUDBw+3J aQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bux284vxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Oct 2021 13:32:04 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19MHS5SH000485;
        Fri, 22 Oct 2021 13:32:03 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bux284vwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Oct 2021 13:32:03 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19MHEUqs026478;
        Fri, 22 Oct 2021 17:32:02 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3bqpcbjgmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Oct 2021 17:32:01 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19MHVxMw65536374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 17:31:59 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 741244204B;
        Fri, 22 Oct 2021 17:31:59 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 098634204C;
        Fri, 22 Oct 2021 17:31:58 +0000 (GMT)
Received: from sig-9-65-85-11.ibm.com (unknown [9.65.85.11])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 22 Oct 2021 17:31:57 +0000 (GMT)
Message-ID: <beedd453a1ec674d3986f7c3851f30df516d2fbb.camel@linux.ibm.com>
Subject: Re: [PATCH v3] integrity: support including firmware ".platform"
 keys at build time
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna <nayna@linux.vnet.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, jarkko@kernel.org, seth.forshee@canonical.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Nayna Jain <nayna@linux.ibm.com>
Date:   Fri, 22 Oct 2021 13:31:57 -0400
In-Reply-To: <03ed8621-8fd0-a83f-24f6-eb9455dc0ca5@linux.vnet.ibm.com>
References: <20211004145258.14056-1-nayna@linux.ibm.com>
         <03ed8621-8fd0-a83f-24f6-eb9455dc0ca5@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LNCtwtP0OBEhkJW0v2DbrWymUsDmRESP
X-Proofpoint-ORIG-GUID: KWv8y4aHdsvB_sL2g0M-TsRM8m0xDpz1
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_04,2021-10-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110220101
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-10-19 at 14:25 -0400, Nayna wrote:
> Gentle reminder for v3. Is this version good now for acceptance ?
> 
> Thanks & Regards,
> 
>       - Nayna
> 
> On 10/4/21 10:52 AM, Nayna Jain wrote:
> > Some firmware support secure boot by embedding static keys to verify the
> > Linux kernel during boot. However, these firmware do not expose an
> > interface for the kernel to load firmware keys onto ".platform" keyring.
> > This would prevent kernel signature verification on kexec.
> >
> > For these environments, a new function load_builtin_platform_cert() is
> > defined to load compiled in certificates onto the ".platform" keyring.
> >
> > load_certificate_list() is currently used for parsing compiled in
> > certificates to be loaded onto the .builtin or .blacklist keyrings.
> > Export load_certificate_list() allowing it to be used for parsing compiled
> > in ".platform" keyring certificates as well.
> >
> > Reported-by: kernel test robot <lkp@intel.com>(auto build test ERROR)
> > Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> > ---
> > NOTE: I am wondering if we should split this patch into two:
> > (https://lore.kernel.org/linux-integrity/be4bd13d-659d-710d-08b9-1a34a65e5c5d@linux.vnet.ibm.com/).
> > I can do so if you also prefer the same.

Yes, splitting this patch would make it easier to review and upstream.

thanks,

Mimi

