Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E0337A9B3
	for <lists+linux-integrity@lfdr.de>; Tue, 11 May 2021 16:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhEKOmL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 May 2021 10:42:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231154AbhEKOmK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 May 2021 10:42:10 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BEYjDF127398;
        Tue, 11 May 2021 10:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=HOkagj6qKX8dDWiwrSAg8Evlind8hlhDNJ6CuYIYWxE=;
 b=bhrO8/1yyIH3wdxruvAuwoiMtzpmJhTlbJgtKXFTxZINIIvTBpCyKgjPyGfGVNCQ8LeD
 tzLXn2NEg8hDPFbpsoxXRvByFvqFMrUF9eEs4tMLBq8GTkmIF+dW0MjndFhneX4Gqr0z
 dQwB2Vf/btN4HChfywTj54VTvBgxKmRoXPDO8MRxrYQNCceGCiGOeF98YXpCxcmtz9S1
 GlpOVKwaPnAO8Yby89JAxlh1Km/gfHZISIF5FnuPeAXTq3g1ge1/vP+FbgIhLMJwMsuA
 YKxK5xXRY+ESvfgYYqTxl6yOPMKpBaQQtS/VS02MHTetCjVeoB3xlUpoLjoMXmFXTqaa LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38fuh68ww8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 10:40:58 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14BEZdZi132272;
        Tue, 11 May 2021 10:40:57 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38fuh68wun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 10:40:57 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14BEdTGG013929;
        Tue, 11 May 2021 14:40:55 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 38dj989qnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 14:40:55 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14BEeQNO20578692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 14:40:26 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 068FBA4062;
        Tue, 11 May 2021 14:40:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 278F9A4054;
        Tue, 11 May 2021 14:40:51 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.116.76])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 May 2021 14:40:50 +0000 (GMT)
Message-ID: <1a5d2a37be31f7971374c01ed8e799e003c96f9d.camel@linux.ibm.com>
Subject: Re: [PATCH v6 08/11] evm: Allow setxattr() and setattr() for
 unmodified metadata
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "mjg59@google.com" <mjg59@google.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        kernel test robot <lkp@intel.com>
Date:   Tue, 11 May 2021 10:40:50 -0400
In-Reply-To: <c281b39bdbaa4b5ab921a2e9cece83b4@huawei.com>
References: <20210505112935.1410679-1-roberto.sassu@huawei.com>
         <20210505113329.1410943-4-roberto.sassu@huawei.com>
         <735bae46f0772b40ef6ecfb3c6fe0267b3ebbee8.camel@linux.ibm.com>
         <c281b39bdbaa4b5ab921a2e9cece83b4@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3g0EOb509lDqu_ZQhOkiIuiCBSc_tMB2
X-Proofpoint-GUID: eBh7C-jKQDPx2nMkGP-7qbaMAYxFM272
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-11_02:2021-05-11,2021-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=992 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105110110
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-05-11 at 14:21 +0000, Roberto Sassu wrote:
> > 
> > On Wed, 2021-05-05 at 13:33 +0200, Roberto Sassu wrote:
> > > With the patch to allow xattr/attr operations if a portable signature
> > > verification fails, cp and tar can copy all xattrs/attrs so that at the
> > > end of the process verification succeeds.
> > >
> > > However, it might happen that the xattrs/attrs are already set to the
> > > correct value (taken at signing time) and signature verification succeeds
> > > before the copy has completed. For example, an archive might contains files
> > > owned by root and the archive is extracted by root.
> > >
> > > Then, since portable signatures are immutable, all subsequent operations
> > > fail (e.g. fchown()), even if the operation is legitimate (does not alter
> > > the current value).
> > >
> > > This patch avoids this problem by reporting successful operation to user
> > > space when that operation does not alter the current value of xattrs/attrs.
> > 
> > I must be missing something.  If both the IMA and EVM status flags are
> > reset after xattr or attr modification, do we really need to prevent
> > any metadata - same or different - changes?  Both evm_protect_xattr()
> > and evm_inode_setattr() would need to be modified to allow
> > INTEGRITY_PASS_IMMUTABLE.
> 
> yes, given that the IMA and EVM flags are reset, it should not be
> a problem to allow changes. However, I think it is useful to keep
> the current behavior. For example, it would prevent an accidental
> change of the SELinux label during the relabeling process.

I understand we might want to prevent accidental or malicious changes,
but that isn't the purpose of this patch set.  The patch description
would also need to be updated to reflect the real purpose.

thanks,

Mimi

