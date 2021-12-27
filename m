Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64A2480138
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Dec 2021 16:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240476AbhL0Pzp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Dec 2021 10:55:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45770 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241039AbhL0PyT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Dec 2021 10:54:19 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BRDki9v013656;
        Mon, 27 Dec 2021 15:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+s1KROujfc4gxOAdQUh50OMhGNh/LaytSn/v2MRhHR0=;
 b=CdVIT9luFZD+8jn1tRYhKHrOqR4yST462uQeIPAPj9SsOaUhJWq3FyWPZgLPL9I0fGZG
 Olzxi1BBhR9d3DnCgLcJQUKGd4rgmGLoYgh/y6QFUveqVfGCGybBBBvyD0mDlmh6HZ7R
 U5pFZKQ8BQWSdEq8wl9/MQgRcI2rdgia/yhKNd1EwM5QBrPQktoIKMD/AMExazMZvoos
 3Wce7kdZ6MRjvLkWeJflBeF3cKzHNWHUBxp/tVyzAniMT/Iadq2/FBeQEkkPhdTYmzUN
 4O3QL4vTi00waqb2Et0IDCTYQdkpP1HlyBuFN5Php5lG70LYH5g1wI0czO4LcJTPpEng Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d7dqek69m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 15:54:18 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BRFsIOd020772;
        Mon, 27 Dec 2021 15:54:18 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d7dqek69c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 15:54:18 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BRFmqv3031284;
        Mon, 27 Dec 2021 15:54:16 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3d5tx9ake0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 15:54:16 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BRFsEQS46793046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Dec 2021 15:54:14 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0B9CA4062;
        Mon, 27 Dec 2021 15:54:13 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B836A405B;
        Mon, 27 Dec 2021 15:54:13 +0000 (GMT)
Received: from sig-9-65-71-16.ibm.com (unknown [9.65.71.16])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Dec 2021 15:54:13 +0000 (GMT)
Message-ID: <41a6ff0500d362f4f03420b75cfe904ff2672f47.camel@linux.ibm.com>
Subject: Re: [PATCH v3] ima: silence measurement list hexdump during kexec
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Bruno Meneguele <bmeneg@redhat.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 27 Dec 2021 10:54:12 -0500
In-Reply-To: <20211227145203.88857-1-bmeneg@redhat.com>
References: <20211227145203.88857-1-bmeneg@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C_sVRECPt_iZx2ANJkC6uXADjlBqvTVU
X-Proofpoint-ORIG-GUID: h2Py4AxnzvPt1PfBq-Sk_7jmPp47FdRe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-27_05,2021-12-24_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112270075
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-12-27 at 11:52 -0300, Bruno Meneguele wrote:
> The measurement list is being dumped during soft resets (kexec) through the
> call to print_hex_dump(KERN_DEBUG, ...) without considering the DEBUG
> compilation flag. With that, to avoid dumping this information to the system
> log whenever a soft reset happens during boot process, since the default
> console loglevel is generally set to 7 (debug) during boot, guard the call
> to print_hex_dump() with #ifdef for the DEBUG cflag.

The patch description needs to be rewritten/simplified.  If the only
problem is that "the console loglevel is generally set to 7 (debug)",
why not begin with the patch description with that?

Other things to consider including in the patch description:
- any side effects of the change (e.g. ability to dynamically enable
output)?

thanks,

Mimi

