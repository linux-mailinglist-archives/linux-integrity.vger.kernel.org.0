Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2660D5A7C5D
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Aug 2022 13:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiHaLoE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 Aug 2022 07:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiHaLoD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 Aug 2022 07:44:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77BCBADA3
        for <linux-integrity@vger.kernel.org>; Wed, 31 Aug 2022 04:44:01 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VAQ7R7006624;
        Wed, 31 Aug 2022 11:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ryhReQJC7e5DLNmj9F9TcyTqnTRIG1v201EAU8M/vm8=;
 b=bCb6Y0Ix+eJ7p8mHVBAdemoLHLFwkOv9tm5DElr4QVAwrLsXXLVpPtpxAPcHeWCyy+XZ
 2gY5/OhLLonUyGhHiXgNg2P8K7UFbWSS9jfWhgEuCujXYgdp/jhE6nwYh/QPxK8M3EH7
 CnFKl8f7ZCtocdYxvHtEHOhKWSi6PqULiuI/HPgqbs+JK4BN17V+It0F6p6ucz68QXIM
 P8Sxn5R8euo8Y8t/RitB0MChxtXeU0KPrQdhUB3tUTQQQZXWBPXUaDCPZuXEL23SnUG/
 sPguUunCemp6oBS0VXb1H7H3Pp++EVB20s6d+VQKAiSWpMTWwItWkrpZ+Ug21XnyzIXS EQ== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ja5vyagyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 11:43:55 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27VBZ7Y7021055;
        Wed, 31 Aug 2022 11:43:54 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01wdc.us.ibm.com with ESMTP id 3j7aw9j55s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 11:43:54 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27VBhr3o27722120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 11:43:53 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0428B6A04D;
        Wed, 31 Aug 2022 11:43:53 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A61686A047;
        Wed, 31 Aug 2022 11:43:52 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.126.199])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 31 Aug 2022 11:43:52 +0000 (GMT)
Message-ID: <735f047390dbe6445ce28c6d40be48689bf27243.camel@linux.ibm.com>
Subject: Re: [RFC PATCH ima-evm-utils 08/11] Deprecate use of OpenSSL 3
 "engine" support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Wed, 31 Aug 2022 07:43:52 -0400
In-Reply-To: <20220830225445.nf6rftpkfv4tgp7h@altlinux.org>
References: <20220830005936.189922-1-zohar@linux.ibm.com>
         <20220830005936.189922-9-zohar@linux.ibm.com>
         <20220830030353.lwggzfsqmalpznoy@altlinux.org>
         <30cc0eab23501c33ab3d2a8e2a6548b92ce9a127.camel@linux.ibm.com>
         <20220830205254.w6cahikybwzmxwkx@altlinux.org>
         <20220830225445.nf6rftpkfv4tgp7h@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d_RB5jgj2vE7s1l7AZGjX70U_Mx8z1tM
X-Proofpoint-ORIG-GUID: d_RB5jgj2vE7s1l7AZGjX70U_Mx8z1tM
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_07,2022-08-31_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=702 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

On Wed, 2022-08-31 at 01:54 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Tue, Aug 30, 2022 at 11:52:54PM +0300, Vitaly Chikunov wrote:
> > On Tue, Aug 30, 2022 at 07:46:40AM -0400, Mimi Zohar wrote:
> > > On Tue, 2022-08-30 at 06:03 +0300, Vitaly Chikunov wrote:
> > > We need to move away from OpenSSL engine support towards providers.
> > 
> > Perhaps they will remove engines (it's not certain) in openssl4,
> > but how many years will pass before that? I don't see why we should
> > hurry in that.
> 
> https://www.openssl.org/policies/releasestrat.html
>   Version 3.0 will be supported until 2026-09-07 (LTS).
> 
> So all that time there will be engines support, even if they decide to
> remove it in next major release. So it doesn't look like we need to
> delete it ASAP.

Agreed there is no rush.  The original intent of this patch set,
however, was to address as many deprecated warnings as possible without
turning them off.   Once they're turned off, they're out of sight, out
of mind.  The only remaining deprecated warnings, without this patch,
are the engine related ones.

The two alternatives both require disabling deprecated warnings:
- invert "--enable-engine" to "--disable-engine" and disable the
deprecated warnings.
- drop this patch and turn off the deprecated warnings, if compiled
with OpenSSL v3.

Mimi

