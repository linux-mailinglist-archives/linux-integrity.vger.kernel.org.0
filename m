Return-Path: <linux-integrity+bounces-7230-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0834CB9360D
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 23:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80B719C102E
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 21:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2610D2F7ABE;
	Mon, 22 Sep 2025 21:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="MY6VWvFh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C80288C9D
	for <linux-integrity@vger.kernel.org>; Mon, 22 Sep 2025 21:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758576688; cv=none; b=HLoX8eqV9iYP28SEPEB/F5C31nnUtXB5zjXx4yP7SmH/jflo4WyRt365N/H8FJ9eGH44DNYPe752VBz2W9LKq1t5WcaoygoQRaNNh55SVEgnqKmdrTCKdQXWNhEFqoZiDrmpRE3s/qKzYZ71mBELwzWrs8IWXe1RfJzCmE+WMF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758576688; c=relaxed/simple;
	bh=8nKfHr/ph7F8GfFB1GkesOp9hG016FLtOApy4Z65/iM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b/oByFdzL75X818WlYKINGvFWzlisA89EdQ3AVtopaJ8Kh8VGOwsZEi7HrfpCoeq+jWXY7zIMATLhmiq0iUqhf2wQuU2/jKDe25fCwfThYyv3+rrn0sTwvVXgFCdYP72HTn6uy1i4Kd+a9Cy4jn+QS2+K2Xvv1Y+nPx9qi91aQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=MY6VWvFh; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1758576685;
	bh=8nKfHr/ph7F8GfFB1GkesOp9hG016FLtOApy4Z65/iM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=MY6VWvFhN0A4eb/e5WDvgvYoiOaasm/FwprogTLxvIWLJeVMOxib+cRUPh9FzFFKb
	 t3b2OgvtSOrPNWV6p0yAFj41HK4Vzmpg7RwwJHb/QZQgXXv9x5TrrsGwegV+ViSf5Z
	 QHFNVpSKHKCEQBbLodJ0fWbiWbvpETajWaarNwuw=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id DB5EA1C02E9;
	Mon, 22 Sep 2025 17:31:24 -0400 (EDT)
Message-ID: <76504837de4d85c385d32f36b8340af0ccad2a09.camel@HansenPartnership.com>
Subject: Re: tpm2key.asn1 parent identification
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, tpm2@lists.linux.dev
Date: Mon, 22 Sep 2025 17:31:24 -0400
In-Reply-To: <aNEPLsJlV6LjnAty@kernel.org>
References: <aMboFXNNX7WZaOaS@kernel.org>
	 <6e1f2713288b48a1cc0311d01e281a98d8e7f45d.camel@HansenPartnership.com>
	 <aMgnm1OkDj9XnStc@kernel.org> <aMhWHy1LQVqpyW5E@kernel.org>
	 <8c2817f5bbf8202b50d93b6044d6595ea4b29b9a.camel@HansenPartnership.com>
	 <aMwptnyYedvdqdHc@kernel.org> <aMxC6hU-UhCP2m6v@kernel.org>
	 <aNEPLsJlV6LjnAty@kernel.org>
Autocrypt: addr=James.Bottomley@HansenPartnership.com;
 prefer-encrypt=mutual;
 keydata=mQENBE58FlABCADPM714lRLxGmba4JFjkocqpj1/6/Cx+IXezcS22azZetzCXDpm2MfNElecY3qkFjfnoffQiw5rrOO0/oRSATOh8+2fmJ6el7naRbDuh+i8lVESfdlkoqX57H5R8h/UTIp6gn1mpNlxjQv6QSZbl551zQ1nmkSVRbA5TbEp4br5GZeJ58esmYDCBwxuFTsSsdzbOBNthLcudWpJZHURfMc0ew24By1nldL9F37AktNcCipKpC2U0NtGlJjYPNSVXrCd1izxKmO7te7BLP+7B4DNj1VRnaf8X9+VIApCi/l4Kdx+ZR3aLTqSuNsIMmXUJ3T8JRl+ag7kby/KBp+0OpotABEBAAG0N0phbWVzIEJvdHRvbWxleSA8SmFtZXMuQm90dG9tbGV5QEhhbnNlblBhcnRuZXJzaGlwLmNvbT6JAVgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAhkBFiEE1WBuc8i0YnG+rZrfgUrkfCFIVNYFAmBLmY0FCRs1hL0ACgkQgUrkfCFIVNaEiQgAg18F4G7PGWQ68xqnIrccke7Reh5thjUz6kQIii6Dh64BDW6/UvXn20UxK2uSs/0TBLO81k1mV4c6rNE+H8b7IEjieGR9frBsp/+Q01JpToJfzzMUY7ZTDV1IXQZ+AY9L7vRzyimnJHx0Ba4JTlAyHB+Ly5i4Ab2+uZcnNfBXquWrG3oPWz+qPK88LJLya5Jxse1m1QT6R/isDuPivBzntLOooxPk+Cwf5sFAAJND+idTAzWzslexr9j7rtQ1UW6FjO4CvK9yVNz7dgG6FvEZl6J/HOr1rivtGgpCZTBzKNF8jg034n49zGfKkkzWLuXbPUOp3/oGfsKv8pnEu1c2GbQpSmFtZXMgQm90dG9tbGV5IDxqZWpiQGxpbnV4LnZuZXQuaWJtLmNvbT6JAVYEEwEIAEACGwMHCwkIBwMCAQYVC
	AIJCgsEFgIDAQIeAQIXgBYhBNVgbnPItGJxvq2a34FK5HwhSFTWBQJgS5mXBQkbNYS9AAoJEIFK5HwhSFTWEYEH/1YZpV+1uCI2MVz0wTRlnO/3OW/xnyigrw+K4cuO7MToo0tHJb/qL9CBJ2ddG6q+GTnF5kqUe87t7M7rSrIcAkIZMbJmtIbKk0j5EstyYqlE1HzvpmssGpg/8uJBBuWbU35af1ubKCjUs1+974mYXkfLmS0a6h+cG7atVLmyClIc2frd3o0zHF9+E7BaB+HQzT4lheQAXv9KI+63ksnbBpcZnS44t6mi1lzUE65+Am1z+1KJurF2Qbj4AkICzJjJa0bXa9DmFunjPhLbCU160LppaG3OksxuNOTkGCo/tEotDOotZNBYejWaXN2nr9WrH5hDfQ5zLayfKMtLSd33T9u0IUphbWVzIEJvdHRvbWxleSA8amVqYkBrZXJuZWwub3JnPokBVQQTAQgAPwIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQTVYG5zyLRicb6tmt+BSuR8IUhU1gUCYEuZmAUJGzWEvQAKCRCBSuR8IUhU1gacCAC+QZN+RQd+FOoh5g884HQm8S07ON0/2EMiaXBiL6KQb5yP3w2PKEhug3+uPzugftUfgPEw6emRucrFFpwguhriGhB3pgWJIrTD4JUevrBgjEGOztJpbD73bLLyitSiPQZ6OFVOqIGhdqlc3n0qoNQ45n/w3LMVj6yP43SfBQeQGEdq4yHQxXPs0XQCbmr6Nf2p8mNsIKRYf90fCDmABH1lfZxoGJH/frQOBCJ9bMRNCNy+aFtjd5m8ka5M7gcDvM7TAsKhD5O5qFs4aJHGajF4gCGoWmXZGrISQvrNl9kWUhgsvoPqb2OTTeAQVRuV8C4FQamxzE3MRNH25j6s/qujtCRKYW1lcyBCb3R0b21sZXkgPGplamJAbGludXguaWJtLmNvbT6JAVQEEwEIAD
	4CGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTVYG5zyLRicb6tmt+BSuR8IUhU1gUCYEuZmQUJGzWEvQAKCRCBSuR8IUhU1kyHB/9VIOkf8RapONUdZ+7FgEpDgESE/y3coDeeb8jrtJyeefWCA0sWU8GSc9KMcMoSUetUreB+fukeVTe/f2NcJ87Bkq5jUEWff4qsbqf5PPM+wlD873StFc6mP8koy8bb7QcH3asH9fDFXUz7Oz5ubI0sE8+qD+Pdlk5qmLY5IiZ4D98V239nrKIhDymcuL7VztyWfdFSnbVXmumIpi79Ox536P2aMe3/v+1jAsFQOIjThMo/2xmLkQiyacB2veMcBzBkcair5WC7SBgrz2YsMCbC37X7crDWmCI3xEuwRAeDNpmxhVCb7jEvigNfRWQ4TYQADdC4KsilPfuW8Edk/8tPtCVKYW1lcyBCb3R0b21sZXkgPEpCb3R0b21sZXlAT2Rpbi5jb20+iQEfBDABAgAJBQJXI+B0Ah0gAAoJEIFK5HwhSFTWzkwH+gOg1UG/oB2lc0DF3lAJPloSIDBW38D3rezXTUiJtAhenWrH2Cl/ejznjdTukxOcuR1bV8zxR9Zs9jhUin2tgCCxIbrdvFIoYilMMRKcue1q0IYQHaqjd7ko8BHn9UysuX8qltJFar0BOClIlH95gdKWJbK46mw7bsXeD66N9IhAsOMJt6mSJmUdIOMuKy4dD4X3adegKMmoTRvHOndZQClTZHiYt5ECRPO534Lb/gyKAKQkFiwirsgx11ZSx3zGlw28brco6ohSLMBylna/Pbbn5hII86cjrCXWtQ4mE0Y6ofeFjpmMdfSRUxy6LHYd3fxVq9PoAJTv7vQ6bLTDFNa0KkphbWVzIEJvdHRvbWxleSA8SkJvdHRvbWxleUBQYXJhbGxlbHMuY29tPokBHwQwAQIACQUCVyPgjAIdIAAKCRCBSuR8IUhU1tXiB/9D9OOU8qB
	CZPxkxB6ofp0j0pbZppRe6iCJ+btWBhSURz25DQzQNu5GVBRQt1Us6v3PPGU1cEWi5WL935nw+1hXPIVB3x8hElvdCO2aU61bMcpFd138AFHMHJ+emboKHblnhuY5+L1OlA1QmPw6wQooCor1h113lZiBZGrPFxjRYbWYVQmVaM6zhkiGgIkzQw/g9v57nAzYuBhFjnVHgmmu6/B0N8z6xD5sSPCZSjYSS38UG9w189S8HVr4eg54jReIEvLPRaxqVEnsoKmLisryyaw3EpqZcYAWoX0Am+58CXq3j5OvrCvbyqQIWFElba3Ka/oT7CnTdo/SUL/jPNobtCxKYW1lcyBCb3R0b21sZXkgPGplamJAaGFuc2VucGFydG5lcnNoaXAuY29tPokBVwQTAQgAQRYhBNVgbnPItGJxvq2a34FK5HwhSFTWBQJjg2eQAhsDBQkbNYS9BQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEIFK5HwhSFTWbtAH/087y9vzXYAHMPbjd8etB/I3OEFKteFacXBRBRDKXI9ZqK5F/xvd1fuehwQWl2Y/sivD4cSAP0iM/rFOwv9GLyrr82pD/GV/+1iXt9kjlLY36/1U2qoyAczY+jsS72aZjWwcO7Og8IYTaRzlqif9Zpfj7Q0Q1e9SAefMlakI6dcZTSlZWaaXCefdPBCc7BZ0SFY4kIg0iqKaagdgQomwW61nJZ+woljMjgv3HKOkiJ+rcB/n+/moryd8RnDhNmvYASheazYvUwaF/aMj5rIb/0w5p6IbFax+wGF5RmH2U5NeUlhIkTodUF/P7g/cJf4HCL+RA1KU/xS9o8zrAOeut2+4UgRaZ7bmEwgqhkjOPQMBBwIDBH4GsIgL0yQij5S5ISDZmlR7qDQPcWUxMVx6zVPsAoITdjKFjaDmUATkS+l5zmiCrUBcJ6MBavPiYQ4kqn4/xwaJAbMEGAEIACYCGwIWIQTVYG5zyLRi
	cb6tmt+BSuR8IUhU1gUCZag0LwUJDwLkSQCBdiAEGRMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCWme25gAKCRDnQslM7pishdi9AQDyOvLYOBkylBqiTlJrMnGCCsWgGZwPpKq3e3s7JQ/xBAEAlx29pPY5z0RLyIDUsjf9mtkSNTaeaQ6TIjDrFa+8XH8JEIFK5HwhSFTWkasH/j7LL9WH9dRfwfTwuMMj1/KGzjU/4KFIu4uKxDaevKpGS7sDx4F56mafCdGD8u4+ri6bJr/3mmuzIdyger0vJdRlTrnpX3ONXvR57p1JHgCljehE1ZB0RCzIk0vKhdt8+CDBQWfKbbKBTmzA7wR68raMQb2D7nQ9d0KXXbtr7Hag29yj92aUAZ/sFoe9RhDOcRUptdYyPKU1JHgJyc0Z7HwNjRSJ4lKJSKP+Px0/XxT3gV3LaDLtHuHa2IujLEAKcPzTr5DOV+xsgA3iSwTYI6H5aEe+ZRv/rA4sdjqRiVpo2d044aCUFUNQ3PiIHPAZR3KK5O64m6+BJMDXBvgSsMy4VgRaZ7clEggqhkjOPQMBBwIDBMfuMuE+PECbOoYjkD0Teno7TDbcgxJNgPV7Y2lQbNBnexMLOEY6/xJzRi1Xm/o9mOyZ+VIj8h4G5V/eWSntNkwDAQgHiQE8BBgBCAAmAhsMFiEE1WBuc8i0YnG+rZrfgUrkfCFIVNYFAmWoNBwFCQ8C4/cACgkQgUrkfCFIVNZs4AgAnIjU1QEPLdpotiy3X01sKUO+hvcT3/Cd6g55sJyKJ5/U0o3f8fdSn6MWPhi1m62zbAxcLJFiTZ3OWNCZAMEvwHrXFb684Ey6yImQ9gm2dG2nVuCzr1+9gIaMSBeZ+4kUJqhdWSJjrNLQG38GbnBuYOJUD+x6oJ2AT10/mQfBVZ3qWDQXr/je2TSf0OIXaWyG6meG5yTqOEv0eaTH22yBb1nbodoZkmlMMb56jzRGZuorhFE06
	N0Eb0kiGz5cCIrHZoH10dHWoa7/Z+AzfL0caOKjcmsnUPcmcrqmWzJTEibLA81z15GBCrldfQVt+dF7Us2kc0hKUgaWeI8Gv4CzwLkCDQRUdhaZARAApeF9gbNSBBudW8xeMQIiB/CZwK4VOEP7nGHZn3UsWemsvE9lvjbFzbqcIkbUp2V6ExM5tyEgzio2BavLe1ZJGHVaKkL3cKLABoYi/yBLEnogPFzzYfK2fdipm2G+GhLaqfDxtAQ7cqXeo1TCsZLSvjD+kLVV1TvKlaHS8tUCh2oUyR7fTbv6WHi5H8DLyR0Pnbt9E9/Gcs1j11JX+MWJ7jset2FVDsB5U1LM70AjhXiDiQCtNJzKaqKdMei8zazWS50iMKKeo4m/adWBjG/8ld3fQ7/Hcj6Opkh8xPaCnmgDZovYGavw4Am2tjRqE6G6rPQpS0we5I6lSsKNBP/2FhLmI9fnsBnZC1l1NrASRSX1BK0xf4LYB2Ww3fYQmbbApAUBbWZ/1aQoc2ECKbSK9iW0gfZ8rDggfMw8nzpmEEExl0hU6wtJLymyDV+QGoPx5KwYK/6qAUNJQInUYz8z2ERM/HOI09Zu3jiauFBDtouSIraX/2DDvTf7Lfe1+ihARFSlp64kEMAsjKutNBK2u5oj4H7hQ7zD+BvWLHxMgysOtYYtwggweOrM/k3RndsZ/z3nsGqF0ggct1VLuH2eznDksI+KkZ3Bg0WihQyJ7Z9omgaQAyRDFct+jnJsv2Iza+xIvPei+fpbGNAyFvj0e+TsZoQGcC34/ipGwze651UAEQEAAYkBHwQoAQIACQUCVT6BaAIdAwAKCRCBSuR8IUhU1p5QCAC7pgjOM17Hxwqz9mlGELilYqjzNPUoZt5xslcTFGxj/QWNzu0K8gEQPePnc5dTfumzWL077nxhdKYtoqwm2C6fOmXiJBZx6khBfRqctUvN2DlOB6dFf5I+1QT9TRBvceGzw01E4Gi0xjWKAB6OII
	MAdnPcDVFzaXJdlAAJdjfg/lyJtAyxifflG8NnXJ3elwGqoBso84XBNWWzbc5VKmatzhYLOvXtfzDhu4mNPv/z7S1HTtRguI0NlH5RVBzSvfzybin9hysE3/+r3C0HJ2xiOHzucNAmG03aztzZYDMTbKQW4bQqeD5MJxT68vBYu8MtzfIe41lSLpb/qlwq1qg0iQElBBgBAgAPBQJUdhaZAhsMBQkA7U4AAAoJEIFK5HwhSFTW3YgH/AyJL2rlCvGrkLcas94ND9Pmn0cUlVrPl7wVGcIV+6I4nrw6u49TyqNMmsYam2YpjervJGgbvIbMzoHFCREi6R9XyUsw5w7GCRoWegw2blZYi5A52xe500+/RruG//MKfOtVUotu3N+u7FcXaYAg9gbYeGNZCV70vI+cnFgq0AEJRdjidzfCWVKPjafTo7jHeFxX7Q22kUfWOkMzzhoDbFg0jPhVYNiEXpNyXCwirzvKA7bvFwZPlRkbfihaiXDE7QKIUtQ10i5kw4C9rqDKwx8F0PaWDRF9gGaKd7/IJGHJaac/OcSJ36zxgkNgLsVX5GUroJ2GaZcR7W9Vppj5H+C4UgRkuRyTEwgqhkjOPQMBBwIDBOySomnsW2SkApXv1zUBaD38dFEj0LQeDEMdSE7bm1fnrdjAYt0f/CtbUUiDaPodQk2qeHzOP6wA/2K6rrjwNIWJAT0EGAEIACcDGyAEFiEE1WBuc8i0YnG+rZrfgUrkfCFIVNYFAmWoM/gFCQSxfmUACgkQgUrkfCFIVNZhTgf/VQxtQ5rgu2aoXh2KOH6naGzPKDkYDJ/K7XCJAq3nJYEpYN8G+F8mL/ql0hrihAsHfjmoDOlt+INa3AcG3v0jDZIMEzmcjAlu7g5NcXS3kntcMHgw3dCgE9eYDaKGipUCubdXvBaZWU6AUlTldaB8FE6u7It7+UO+IW4/L+KpLYKs8V5POInu2rqahlm7vgxY5iv4Txz4EvCW2e4dAlG
	8mT2Eh9SkH+YVOmaKsajgZgrBxA7fWmGoxXswEVxJIFj3vW7yNc0C5HaUdYa5iGOMs4kg2ht4s7yy7NRQuh7BifWjo6BQ6k4S1H+6axZucxhSV1L6zN9d+lr3Xo/vy1unzA==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-22 at 11:56 +0300, Jarkko Sakkinen wrote:
> On Thu, Sep 18, 2025 at 08:35:38PM +0300, Jarkko Sakkinen wrote:
> > On Thu, Sep 18, 2025 at 06:48:06PM +0300, Jarkko Sakkinen wrote:
> > > On Tue, Sep 16, 2025 at 10:33:43PM -0400, James Bottomley wrote:
> > > > On Mon, 2025-09-15 at 21:08 +0300, Jarkko Sakkinen wrote:
> > > > > On Mon, Sep 15, 2025 at 05:50:07PM +0300, Jarkko Sakkinen
> > > > > wrote:
> > > > > > On Sun, Sep 14, 2025 at 11:24:24PM -0400, James Bottomley
> > > > > > wrote:
> > > > > > > On Sun, 2025-09-14 at 19:08 +0300, Jarkko Sakkinen wrote:
> > > > > > > > Hi,
> > > > > > > >=20
> > > > > > > > In practice, while implementing tpm2sh and its self-
> > > > > > > > contained TPM emulator called "MockTPM", I've noticed
> > > > > > > > that 'tpm2key.asn1.' has a major bottleneck, but
> > > > > > > > luckily it is easy to squash.
> > > > > > > >=20
> > > > > > > > Parent handle should never be persisted, as it defies
> > > > > > > > the existential reason of having a file format in the
> > > > > > > > first place.
> > > > > > >=20
> > > > > > > Actually, if you read the spec:it describes how to handle
> > > > > > > non-persistent parents by defining the exact form of the
> > > > > > > P256 parent you derive from the permanent handle in
> > > > > > > section 3.1.8:
> > > > > > >=20
> > > > > > > https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.h=
tml
> > > > > > >=20
> > > > > > > This is the way all the implementations (well except the
> > > > > > > kernel, but that's fixable) do it.
> > > > > >=20
> > > > > > Even if you fix it to persistent handle, the problem does
> > > > > > not go magically go away. Read public attributes are
> > > > > > ubiquitos and cryptographically correct way to do the
> > > > > > binding.
> > > > > >=20
> > > > > > >=20
> > > > > > > > To address this issue I just added couple of optional
> > > > > > > > fields to
> > > > > > > > TPMKey:
> > > > > > > >=20
> > > > > > > > =C2=A0 parentName=C2=A0=C2=A0 [6] EXPLICIT OCTET STRING OPT=
IONAL,
> > > > > > > > =C2=A0 parentPubkey [7] EXPLICIT OCTET STRING OPTIONAL
> > > > > > >=20
> > > > > > > So that's a bit redundant, since if you know the key, you
> > > > > > > know
> > > > > > > its name.
> > > > > >=20
> > > > > > What I know is irrelevant here :-)
> > > > > >=20
> > > > > > >=20
> > > > > > > > By persisting this information TPM2_GetCapability +
> > > > > > > > TPM2_ReadPublic can be used to acquire an appropriate
> > > > > > > > handle.
> > > > > > >=20
> > > > > > > It can, how?=C2=A0 If the parent is a primary, you can't
> > > > > > > insert it from a public key, you have to derive it and if
> > > > > > > it's non-primary, you need its parent to do the
> > > > > > > insertion.
> > > > > >=20
> > > > > > Transient handle is like file handle and persistent handle
> > > > > > is like inode number. Neither unambigiuously (and this is
> > > > > > dead obvious) does not identify any possible key.
> > > > > >=20
> > > > > > Further by binding key correctly, the requirement of being
> > > > > > persistent key goes away, which is a limiting factor.
> > > > > >=20
> > > > > > >=20
> > > > > > > > I'd highly recommend to add this quirk to anything that
> > > > > > > > processes this ASN.1 format.
> > > > > > >=20
> > > > > > > Well, patches to the standard are accepted:
> > > > > > >=20
> > > > > > > https://groups.io/g/openssl-tpm2-engine/topics
> > > > >=20
> > > > > Further there is two options:
> > > > >=20
> > > > > 1. Either remove TPM2 key ASN.1 support from kernel entirely.
> > > > > 2. Fix the 0day bug.
> > > >=20
> > > > Can you please explain in technical terms what you see as a
> > > > zero day bug in the current implementation?
> > >=20
> > > It's essentially ambiguity problem in my opinion that locks in
> > > the creator TPM if you know the expected parent. 0day might be
> > > overstatement yes, but it is essentially the immutable reference
> > > in this scheme. If you want to scope it, it's essentially a great
> > > way to add some defence in depth to the scheme.
> > >=20
> > > >=20
> > > > > It is unacceptable to make strong binding to a random open
> > > > > source project. I zero care what OpenSSL TPM2 engine does
> > > > > with the file format.
> >=20
> > The way I see it, a "random project" would apply to any project
> > that a format is locked in, and it is quite obvious that fixing
> > handle as the anchor is exactly fit for exactly for this project,
> > and within those exact limits it is probably a sustainable choice.
> >=20
> > Being able to fix key into cryptographic=C2=A0 identity is somewhat san=
e
> > addition because not only does it lock-in the creator but it also
> > allows to use offline stored keys with the same scheme i.e.,
> > non-endorsement hierarchy derived keys created with TPM2_Create or
> > TPM2_Import.
> >=20
> > In the context of OpenSSL TPM2 engine, perhaps the current scheme
> > is fine but in the context of supporting a "ecosystem" as a kernel
> > feature it's not in its current form robust enough.
> >=20
> > And how else I can describe it other than I don't care about the
> > project, if the file format enforces me align with it?
>=20
> The ASN.1 definition limits types of keys while there's no any good
> reasons to disregard transient keys.=20

As I explained in the bit you quote above, the spec covers volatile
parents.

> It also enforces handle numbers, which is not very robust approach.

I think if you read the spec, you'll find it only requires handle
numbers for persistent keys ... specific handle numbers being a feature
of those keys required by TPM spec.

> I've neither seen any cryptographic object in my life, which uses
> ambiguous data as part of the identity no matter how hypothetical
> the possible threat scenarios are. It's a bad security practice
> plain and simple.

This contains no actionable technical content.  However, it is possible
the spec doesn't cover your use case, it's just you haven't actually
outlined what your use case is, so no-one who knows the spec can
actually confirm or deny this.

Regards,

James


