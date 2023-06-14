Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C974B730017
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jun 2023 15:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245014AbjFNNaX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Jun 2023 09:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245019AbjFNNaV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Jun 2023 09:30:21 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8E61FF7;
        Wed, 14 Jun 2023 06:30:18 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EDLSuw027897;
        Wed, 14 Jun 2023 13:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ILVPSf3o9GLRJAOnBHDkXiB2yee3btVY+Xuw+FhOo0A=;
 b=WByMOWqLiC+0BtwjIBqYUr3q4Bxa3K1A34gsYm6EH6jrd3gQmTJ6PMxeX6+skYOXENHY
 fS7D9z0qI9k7kjn8cU85oAKwJsFcPcw2sZ2BYOwf+fZdxw5LRrgzDVtXCoCtsmI3BxVm
 r9Xz5cXP2SonOsE2Gh6SfTVMxyRC5WyPC4gePKGSVGB86NaYLnuzUhsWM+lxtWqzDxok
 3j9EjaqQmrfrkLIF0QQBhEqzqB/hAg7QIXzhCpiMSub09x3nc9wn1GR0sDcdG6Auia/k
 +xTc+yzG59L8NT8FP4uTcagP39/8VoijuEeNUgbENJXBJsS0ZGBakvBHO1f30ScHgLS8 jA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7ec0g78h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 13:30:04 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35EDNcKg002782;
        Wed, 14 Jun 2023 13:30:04 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7ec0g77s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 13:30:03 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35ECx8A2014554;
        Wed, 14 Jun 2023 13:30:03 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3r4gt5nv4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 13:30:03 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35EDU1Dv55575000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 13:30:01 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C1DA58067;
        Wed, 14 Jun 2023 13:30:01 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E12A558069;
        Wed, 14 Jun 2023 13:30:00 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.19.215])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 14 Jun 2023 13:30:00 +0000 (GMT)
Message-ID: <a8e4d70d2b46f41827375d9290131ea93ad5830a.camel@linux.ibm.com>
Subject: Re: [PATCH] fsverity: rework fsverity_get_digest() again
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Biggers <ebiggers@kernel.org>, fsverity@lists.linux.dev
Cc:     linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Alexander Larsson <alexl@redhat.com>
Date:   Wed, 14 Jun 2023 09:30:00 -0400
In-Reply-To: <20230612190047.59755-1-ebiggers@kernel.org>
References: <20230612190047.59755-1-ebiggers@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _R_OBG5ealS_BdfMCy1swJOnlj1gRx0a
X-Proofpoint-ORIG-GUID: K5PbRqElOIh5cgd4WnaMVzObC6uOOSie
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_08,2023-06-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-06-12 at 12:00 -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Address several issues with the calling convention and documentation of
> fsverity_get_digest():
> 
> - Make it provide the hash algorithm as either a FS_VERITY_HASH_ALG_*
>   value or HASH_ALGO_* value, at the caller's choice, rather than only a
>   HASH_ALGO_* value as it did before.  This allows callers to work with
>   the fsverity native algorithm numbers if they want to.  HASH_ALGO_* is
>   what IMA uses, but other users (e.g. overlayfs) should use
>   FS_VERITY_HASH_ALG_* to match fsverity-utils and the fsverity UAPI.
> 
> - Make it return the digest size so that it doesn't need to be looked up
>   separately.  Use the return value for this, since 0 works nicely for
>   the "file doesn't have fsverity enabled" case.  This also makes it
>   clear that no other errors are possible.
> 
> - Rename the 'digest' parameter to 'raw_digest' and clearly document
>   that it is only useful in combination with the algorithm ID.  This
>   hopefully clears up a point of confusion.
> 
> - Export it to modules, since overlayfs will need it for checking the
>   fsverity digests of lowerdata files
>   (https://lore.kernel.org/r/dd294a44e8f401e6b5140029d8355f88748cd8fd.1686565330.git.alexl@redhat.com).
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Acked-by: Mimi Zohar <zohar@linux.ibm.com> for the IMA piece.

