Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B16D2A2FEA
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Nov 2020 17:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgKBQgH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Nov 2020 11:36:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726775AbgKBQgH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Nov 2020 11:36:07 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A2GWWUf159009;
        Mon, 2 Nov 2020 11:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=MVcg6nGdKKAdwWiheTE9fesBPLlSv5GUCF0nN+4SDg8=;
 b=rDUn4IW28V3ykJZdA6B+yJAlu47VNsZZfCyhiXD7s2GbCLB7wYsBF6FSIHBgjzoI0Gz2
 BN2zWXArmoekGwTNlcgDU1xO1oZIR9GKAHGXNvMrpEKZniM3HeO1s/nKdBHesroRhkkV
 rFUvgi0KNQ6USJq6KBflip6+d5JtdYkoX2KMkCJSqJQQ2sh9Dy9cyDbD/C33R1zMUvVJ
 Fs+wlC+Y84zVHnIT1/P+pDYSimmlGzHwbMbuvUUYnuPSnxifwdTgnhwuwKQVwES/pt5Q
 98BXZABv21JmFUWaTjsLuRKVvzW0xdGj81Xvh0eXYFagu8051KflcbHdCiZ2aIDgMnPv gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34jfg7cx1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Nov 2020 11:36:05 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A2GXhmp169250;
        Mon, 2 Nov 2020 11:36:04 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34jfg7cx0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Nov 2020 11:36:04 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A2GRclK006394;
        Mon, 2 Nov 2020 16:36:02 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 34j6j40dag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Nov 2020 16:36:02 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A2GZxP317957262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Nov 2020 16:36:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE7C8A4064;
        Mon,  2 Nov 2020 16:35:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70D45A405C;
        Mon,  2 Nov 2020 16:35:58 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.45.94])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Nov 2020 16:35:58 +0000 (GMT)
Message-ID: <66678394f824be5367cc0e1745f1bda98b436550.camel@linux.ibm.com>
Subject: Re: [RFC] Finding the right target branch for patches that span IMA
 and SeLinux
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SELinux <selinux@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Date:   Mon, 02 Nov 2020 11:35:57 -0500
In-Reply-To: <9195fd7a-a5c5-8588-d33c-772d2f530032@linux.microsoft.com>
References: <703ced1a-3a48-f29e-9141-af78415d8402@linux.microsoft.com>
         <f99f0f03aecc778826d79eb83d60cfd1a95196c5.camel@linux.ibm.com>
         <2ea3d341-6299-ec40-b553-f9f59a36cfb3@linux.microsoft.com>
         <CAHC9VhR8mbqZS3TVgG7MxQywe9uqDRCN+c59PozLTpOoQ-mK7Q@mail.gmail.com>
         <9195fd7a-a5c5-8588-d33c-772d2f530032@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-02_09:2020-11-02,2020-11-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011020124
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2020-10-31 at 20:08 -0700, Tushar Sugandhi wrote:
> Hi Paul,
> 
> On 2020-10-30 1:37 p.m., Paul Moore wrote:
> > On Fri, Oct 30, 2020 at 12:43 PM Tushar Sugandhi
> > <tusharsu@linux.microsoft.com> wrote:
> >>> Unless this patch set is specifically dependent on the two patches in
> >>> the SELinux tree beyond v5.10.0-rc1, please base it on v5.10.0-rc1.
> >>
> >> Thanks Mimi. We don't have dependencies on those two patches in SELinux
> >> tree.
> >>
> >> We'll base our changes on v5.10.0-rc1 in SELinux tree.
> >>
> >> Thanks for the quick response.
> > 
> > I'm not as fast as Mimi, but I thought it might be worthwhile to
> > provide a bit more detail as to what I expect from SELinux kernel
> > submissions.  I believe most other maintainers operate in a similar
> > manner, but I obviously can't speak for them.
> Thanks a lot for the detailed information Paul.
> Its very helpful, and we appreciate it.
> > 
> > Unless there is an exception due to a previous discussion, I ask that
> > all SELinux kernel patches be based on either the selinux/next branch
> > or Linus' current tree.  If your patch(set) applies cleanly to either
> > of those branches, and passes review, I'll merge it into the
> > selinux/next branch taking care of any merge conflicts that may arise.
> We will base on SeLinux -> next branch, as you/Mimi suggested.

Unless there was a compelling reason for basing it on the SELinux
branch, I asked that you base the changes on v5.10.0-rc1 (or later),
which has nothing to do with the SELinux branch.  Once this patch set
is reviewed and ready to be upstreamed, a topic branch will be created
containing at least the IMA patches.   The decision as to how the the
SELinux patch will be upstreamed will be made at that point.  That
discussion will be between Paul and me.

thanks,

Mimi

